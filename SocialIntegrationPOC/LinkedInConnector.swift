//
//  LinkedInConnector.swift
//  SocialIntegrationPOC
//
//  Created by Keegan Rush on 2016/12/30.
//  Copyright © 2016 The Coded Self. All rights reserved.
//

import Foundation

struct LinkedInConnector {
    
    static var sharedInstance = LinkedInConnector()

    private static let userDefaultsAccessTokenKey = "linkedInAccessTokenKey"
    private static let key = "86pfwqq0kiw1i6"
    private static let secret = "Orey7lQPqIpOhP8b"
    private static let apiUrl = "https://www.linkedin.com/uas/oauth2/"
    private static let redirectUrl = "https://com.thecodedself.SocialIntegrationPOC/oauth".addingPercentEncoding(withAllowedCharacters: .alphanumerics)!

    private var accessToken: String? {
        set(newToken) {
            UserDefaults.standard.setValue(newToken, forKey: LinkedInConnector.userDefaultsAccessTokenKey)
        }
        get {
            return UserDefaults.standard.value(forKey: LinkedInConnector.userDefaultsAccessTokenKey) as? String
        }
        
    }
    
    var connected: Bool {
        return accessToken != nil
    }
    
    func authCodeRequest() -> URLRequest {
        let responseType = "code"
        let state = "linkedin\(Int(Date().timeIntervalSince1970))"
        let scope = "r_emailaddress"
        
        let authorizationUrl = "\(LinkedInConnector.apiUrl)authorization?"
                + "response_type=\(responseType)&"
                + "client_id=\(LinkedInConnector.key)&"
                + "redirect_uri=\(LinkedInConnector.redirectUrl)&"
                + "state=\(state)&"
                + "scope=\(scope)"
        
        return URLRequest(url: URL(string: authorizationUrl)!)
    }
    
    func getProfileUrlString(completion: @escaping (String?) -> ()) {
        
        let targetURLString = "https://api.linkedin.com/v1/people/~:(public-profile-url)?format=json"
        var request = URLRequest(url: URL(string: targetURLString)!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completion(nil)
                    return
            }
            
            let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]
            let profileURLString = dataDictionary??["publicProfileUrl"] as? String
            completion(profileURLString)
            }
            
        task.resume()
    }
    
    mutating func setAccessToken(_ token: String) {
        accessToken = token
    }
    
    func requestAccessToken(authCode: String, completion: @escaping (String?) -> ()) {
        
        let request = createHttpPostRequest(authCode: authCode)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200 else {
                    completion(nil)
                    return
            }
        
            let dataDictionary = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]
            let accessToken = dataDictionary??["access_token"] as? String
            completion(accessToken)
        }
        
        task.resume()
    }
    
    private func createHttpPostRequest(authCode: String) -> URLRequest {
        let postParams = "grant_type=authorization_code&"
            + "code=\(authCode)&"
            + "redirect_uri=\(LinkedInConnector.redirectUrl)&"
            + "client_id=\(LinkedInConnector.key)&"
            + "client_secret=\(LinkedInConnector.secret)"
        
        let postData = postParams.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "\(LinkedInConnector.apiUrl)accessToken")!)
        request.httpMethod = "POST"
        request.httpBody = postData
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
}
