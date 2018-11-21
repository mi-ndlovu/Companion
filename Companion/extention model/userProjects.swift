//
//  userProjects.swift
//  companion
//
//  Created by Mfundo MTHETHWA on 2018/10/17.
//  Copyright © 2018 Mfundo MTHETHWA. All rights reserved.
//

import Foundation
import UIKit

public struct userProject {
    public let name : String
    public let grade : Double
    public let validated : Bool
    public let slug : String
}

public struct Projects {
    public var projects = [userProject]()
    
    /*
     mutating enables the method to have the ability to mutate the values of
     the properties and write it back to the original structure
     */
    mutating func getProjects(Name name:String, Grade grade:Double, Validated validated:Bool, Slug slug:String) {
        let list = userProject(name: name, grade: grade, validated: validated, slug: slug)
        self.projects.append(list)
    }
}

extension TokenHTTPrequest {
    public func userProjects(Json json:NSDictionary) -> Projects {
        var projects = Projects()
        if let usersProject = json["projects_users"] as? [NSDictionary] {
            for elem in usersProject {
                var name = ""
                let grade = elem["final_mark"] as? Double ?? 0.0
                let validated = elem["validated?"] as? Bool ?? false
                var slug = ""
                if let projectName = elem["project"] as? NSDictionary {
                    name = projectName["name"] as? String ?? "N/A"
                    slug = projectName["slug"] as? String ?? "N/A"
                }
                projects.getProjects(Name: name, Grade: grade, Validated: validated, Slug: slug)
            }
        }
        return projects
    }
}
