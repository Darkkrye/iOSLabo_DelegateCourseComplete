//
//  APIManager.swift
//  iOSLabo_DelegateCourse
//
//  Created by Pierre on 03/12/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import UIKit

// APIManager Delegate Protocol
// Create APIManagerDelegate protocol
// Create getUserReposCallback function
@objc protocol APIManagerDelegate {
    func getUserReposCallback(statusCode: Int, userData: Data, reposData: Data)
}

// APIManager Singleton Class
class APIManager: NSObject {
    
    // Create delegate variable
    var delegate: APIManagerDelegate?
    
    // Singleton variable
    static var shared = APIManager()
    var headers = ["Content-Type": "application/json"]
    
    // Endpoints
    fileprivate var ENDPOINT = "https://ioslab-delegatecourse.herokuapp.com/"
    fileprivate var REPOEXTENSION = "?repo=true"
    
    fileprivate var userData: Data?
    
    // Private constructor for Singleton
    private override init() {}
}

// Extension for requests
extension APIManager {
    fileprivate func getRequest(route: String, headers: [String: String], callback: APIManagerCallback) {
        var request = URLRequest(url: URL(string: route)!)
        
        request.httpMethod = HTTPMethod.GET.rawValue
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            let realResponse = response as! HTTPURLResponse
            self.sendToCallback(statusCode: realResponse.statusCode, data: data!, callback: callback)
        }).resume()
    }
}

// Extension for selecting callback function
extension APIManager {
    fileprivate func sendToCallback(statusCode: Int, data: Data, callback: APIManagerCallback) {
        // Send the information for the good callback function
        if let d = self.delegate {
            switch callback {
            case .GETUSER:
                self.userData = data
                self.getUserRepository()
                break
                
            case .GETREPOS:
                d.getUserReposCallback(statusCode: statusCode, userData: self.userData!, reposData: data)
                break
            }
        }
    }
}

// Extension for APIManager functions
extension APIManager {
    func getGithubUserInformation() {
        self.getRequest(route: self.ENDPOINT, headers: self.headers, callback: .GETUSER)
    }
    
    fileprivate func getUserRepository() {
        self.getRequest(route: "\(self.ENDPOINT)\(self.REPOEXTENSION)", headers: self.headers, callback: .GETREPOS)
    }
}

// Enum for APIManager Callbacks
enum APIManagerCallback {
    case GETUSER
    case GETREPOS
}

// Enum for HTTP Verbs
enum HTTPMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}
