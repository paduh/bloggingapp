//
//  Router.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation
import UIKit
import SystemConfiguration

// MARK: - Router

public final class Router<EndPoint: EndPointType, T: Codable>: NSObject, NetworkRouter, URLSessionDelegate {
    
    // MARK: - Properties
    
    private var task: URLSessionTask?
    public typealias NetworkRouterCompletion = ((Result<T?>)->())
    
    public func request(route: EndPoint, logContent: Bool = true, completion: @escaping NetworkRouterCompletion) {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 90.0
        sessionConfig.timeoutIntervalForResource = 90.0
        let session = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        completion(.failure(NetworkResponse.noNetworkConnection))
                    }
                    return
                }
                if let response = response as? HTTPURLResponse {
                    print(response)
                    let result = response.handleNetworkResponse()
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                            guard let responseData = data else {
                                completion(.failure(NetworkResponse.noData))
                                return
                            }
                            do {
                                let apiResponse = try JSONDecoder().decode(T.self, from: responseData)
                                completion(.success(apiResponse))
                            }catch {
                                print(error)
                                completion(.failure(NetworkResponse.unableToDecode))
                            }
                        case .failure(let error):
                            completion(.failure(.custom(info: error)))
                        }
                    }
                }
            })
        } catch let error {
            DispatchQueue.main.async {
                completion(.failure(.custom(info: error.localizedDescription)))
            }
        }
        self.task?.resume()
    }
    
    public func cancel() {
        
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseUrl.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            case .imageUpload(let image, let additionalHeaders):
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try request.setMultipartBodyImage(image)
                
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            if let trust = challenge.protectionSpace.serverTrust {
                completionHandler(.useCredential, URLCredential(trust: trust))
            }
        }
    }
    
    public func checkNetwork(completion: @escaping (NetworkState) -> Void) {
         var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
         zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
         zeroAddress.sin_family = sa_family_t(AF_INET)
         let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
             $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                 SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
             }
         }
         /// check the reachbility flag on the device
         var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
         if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
             completion(.unavailable)
             return
         }
         let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
         let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
         let ret = (isReachable && !needsConnection)
         if(ret){
             /// Returns the availability if network is available
             completion(.available)
         }else{
             completion(.unavailable)
         }
     }
}

public enum NetworkState {
    case available
    case unavailable
}

// MARK: - Router

extension URLRequest {
    
    /**
     Configures the URL request for `multipart/form-data`. The request's `httpBody` is set, and a value is set for the HTTP header field `Content-Type`.
     
     - Parameter parameters: The form data to set.
     - Parameter encoding: The encoding to use for the keys and values.
     
     - Throws: `MultipartFormDataEncodingError` if any keys or values in `parameters` are not entirely in `encoding`.
     
     - Note: The default `httpMethod` is `GET`, and `GET` requests do not typically have a response body. Remember to set the `httpMethod` to e.g. `POST` before sending the request.
     - See also: https://html.spec.whatwg.org/multipage/form-control-infrastructure.html#multipart-form-data
     */
    public mutating func setMultipartBodyImage(_ image: UIImage) throws {
        
        // MARK: - Properties
        
        let makeRandom = { UInt32.random(in: (.min)...(.max)) }
        let boundary = String(format: "------------------------%08X%08X", makeRandom(), makeRandom())
        let filename = "image.jpg"
        
        let contentType = "multipart/form-data; boundary=\(boundary)"
        setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        httpBody =  {
            var data = Data()
            
            // Add the image data to the raw http request data
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"image\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            data.append(image.jpegData(compressionQuality: 0.5)!)
            
            // End the raw http request data, note that there is 2 extra dash ("-") at the end, this is to indicate the end of the data
            // According to the HTTP 1.1 specification https://tools.ietf.org/html/rfc7230
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            
            return data
            }()
    }
}

// MARK: - MultipartFormDataEncodingError

public enum MultipartFormDataEncodingError: Error {
    case name(String)
    case value(String, name: String)
}