//
//  userSkills.swift
//  companion
//
//  Created by Mfundo MTHETHWA on 2018/10/17.
//  Copyright © 2018 Mfundo MTHETHWA. All rights reserved.
//

import Foundation
import UIKit

public struct userSkills {
    public let name : String
    public let level : Double
}

public struct Skills {
    public var skills = [userSkills]()
    
    /*
     mutating enables the method to have the ability to mutate the values of
     the properties and write it back to the original structure
     */
    mutating func getSkills(Name name:String, Level level:Double) {
        let list = userSkills(name: name, level: level)
        self.skills.append(list)
    }
}

extension TokenHTTPrequest {
    public func userSkills(Json json:NSDictionary) -> Skills {
        var skills = Skills()
        if let cursus = json["cursus_users"] as? [NSDictionary] {
            for elem in cursus {
                if let userSkills = elem["skills"] as? [NSDictionary] {
                    for uSkills in userSkills {
                        let name = uSkills["name"] as? String ?? "N/A"
                        let level = uSkills["level"] as? Double ?? -1.0
                        skills.getSkills(Name: name, Level: level)
                    }
                }
            }
        }
        return skills
    }
}
