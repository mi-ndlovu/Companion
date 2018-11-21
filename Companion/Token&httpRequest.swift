//
//  Token&httpRequest.swift
//  companion
//
//  Created by Mfundo MTHETHWA on 2018/10/16.
//  Copyright © 2018 Mfundo MTHETHWA. All rights reserved.
//

import Foundation

public class TokenHTTPrequest {
    // creating instance to access the token class
    private var token = Token()
    // accessing the clientInfo struct
    private let clientInfo = ClientInfo()
    
    // function which gets the token
    private func getToken(Callback callback: @escaping (Token?) -> Void) {
        if let url = URL(string: clientInfo.tokenUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            let httpString = "grant_type=client_credentials&client_id=\(clientInfo.uid)&client_secret=\(clientInfo.secret)"
            request.httpBody = httpString.data(using: String.Encoding.utf8)
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let d = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            let token = json["access_token"] as? String ?? "N/A"
                            let type = json["token_type"] as? String ?? "N/A"
                            let expire = json["expires_in"] as? Int ?? -1
                            let scope = json["scope"] as? String ?? "N/A"
                            let create = json["created_at"] as? Int ?? -1
                            DispatchQueue.main.async {
                                self.token.setToken(AccessToken: token, Type: type, TimeExpires: expire, Scope: scope, Created: create)
                                callback(self.token)
                            }
                        }
                    }
                    catch let err {
                        print("Error: \(err)")
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    private func authRequest(_ login:String, Callback callback: @escaping (UserInfo?, String?) -> Void) {
        if let url = URL(string: clientInfo.userUrl + login) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("Bearer \(token.bearerToken)", forHTTPHeaderField: "Authorization")
            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let d = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                            let profile = self.userProfile(Json: json)
                            let skills = self.userSkills(Json: json)
                            let projects = self.userProjects(Json: json)
                            let user = UserInfo(Profile: profile, Skills: skills, Projects: projects)
                            callback(user, nil)
                        }
                    }
                    catch {
                        callback(nil, "Invalid request")
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    public func validateRequest(Login login:String, Callback callback: @escaping (UserInfo?, String?) ->Void) {
        if token.isValid {
            authRequest(login, Callback: callback)
        } else {
            getToken() {
                token in
                if token != nil {
                    self.validateRequest(Login: login, Callback: callback)
                }
            }
        }
    }
    
}
