//
//  model.swift
//  companion
//
//  Created by Mfundo MTHETHWA on 2018/10/16.
//  Copyright © 2018 Mfundo MTHETHWA. All rights reserved.
//

import Foundation
import UIKit

public struct ClientInfo {
    public let uid = "fe55637c623031cb20c5748d1930eb4046709541d4840c142df148809416b070"
    public let secret = "9bb43e7da2b2a9cd26c205ba4fcc61dc28554ebce60ae86bf08b936ea3bfb79a"
    public let tokenUrl = "https://api.intra.42.fr/oauth/token"
    public let userUrl = "https://api.intra.42.fr/v2/users/"
}

public class Token: CustomStringConvertible {
    
    private var accessToken : String!
    private var tokenType : String!
    private var tokenCreated : Int!
    private var tokenIsSet = false
    fileprivate var tokenExpired : Int!
    private var tokentimeStamp : Int!
    private var scope : String!
    
    public var bearerToken : String {
        if accessToken != nil {
            return accessToken!
        } else {
            return "Invalid Token"
        }
    }
    
    public var isValid : Bool {
        if tokenIsSet {
            let currentTime = Int(Date().timeIntervalSinceNow)
            return tokentimeStamp - currentTime > 0
        }
        return false
    }
    
    public func setToken(AccessToken token:String, Type type:String, TimeExpires timeExpires:Int, Scope scope:String, Created created:Int) {
        self.accessToken = token
        self.tokenType = type
        self.tokenExpired = timeExpires
        self.scope = scope
        self.tokenCreated = created
        self.tokenIsSet = true
        self.tokentimeStamp = Int(Date().timeIntervalSinceNow) + timeExpires
    }
    
    public var description: String {
        return "token = \(accessToken)" +
            "\nType = \(tokenType)" +
            "\nExpire in = \(tokenExpired)" +
            "\nScope = \(scope)" +
            "\nCreated at = \(tokenCreated)"
    }
}

public class UserInfo : Hashable {
    
    public static func == (lhs: UserInfo, rhs: UserInfo) -> Bool {
        return lhs.profile.login == rhs.profile.login
    }
    
    public var profile : Profile
    public var skills : Skills
    public var projects : Projects
    
    init(Profile profile:Profile, Skills skills:Skills, Projects projects:Projects) {
        self.profile = profile
        self.skills = skills
        self.projects = projects
    }
    
    public var hashValue: Int {
        return profile.login.hashValue
    }
}



