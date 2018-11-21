//
//  APIController.swift
//  companion
//
//  Created by Mfundo MTHETHWA on 2018/10/16.
//  Copyright © 2018 Mfundo MTHETHWA. All rights reserved.
//

import Foundation

public class manageUsers {
    private var data = [UserInfo]()
    public var getData : [UserInfo] {
        return data
    }
    
    /*
     subscripts are used to set and get values by index without
     needing separate methods for setting and getting
     */
    subscript (index: Int) -> UserInfo {
        get {
            return data[index]
        } set {
            data.insert(newValue, at: index)
        }
    }
    
    func addUser(User user:UserInfo) {
        if data.contains(user) == false {
            data.append(user)
        }
    }
}

public class APIController {
    public static let api42 = APIController()
    public weak var delegate : API42Delegate?
    public var loggedInUser : UserInfo?
    private let httpRequest = TokenHTTPrequest()
    private let UserData = manageUsers()
    
    public func getUser() -> [UserInfo] {
        return UserData.getData
    }
    
    public func loginAuth(Login login:String) {
        let trim = login.trimmingCharacters(in: CharacterSet.whitespaces)
        /*
         addingPercentEncoding() Returns a new string made from the receiver by replacing all characters
         not in the specified set with percent-encoded characters
         */
        if let query = trim.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            httpRequest.validateRequest(Login: query) { userdata, error in
                if let user = userdata {
                    if user.profile.login != "N/A" {
                       DispatchQueue.main.async {
                            self.loggedInUser = user
                            self.UserData.addUser(User: user)
                            self.delegate?.handleUser(User: user)
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            self.delegate?.handleError(Errors: "Invalid Username")
                        }
                    }
                }
                if let _ = error {
                    DispatchQueue.main.async {
                        self.delegate?.handleError(Errors: "HTTP failed to Load")
                    }
                }
            }
        }
    }
}
