//
//  HTTPTask.swift
//  bloggingapp
//
//  Created by Aduh Perfect on 19/07/2021.
//

import Foundation
import UIKit

// MARK:- HTTPHeadeers Typealias

public typealias HTTPHeaders = [String: String]

// MARK:- HTTPTask

public enum HTTPTask {
    
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    case imageUpload(image: UIImage, additionHeaders: HTTPHeaders?)
    
    // case download, upload...etc
}
