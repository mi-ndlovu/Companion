//
//  userProfile.swift
//  companion
//
//  Created by Mfundo MTHETHWA on 2018/10/16.
//  Copyright © 2018 Mfundo MTHETHWA. All rights reserved.
//

import Foundation
import UIKit

public struct Profile {
    public let login : String
    let firstName : String
    let lastName : String
    let email : String
    let correctionPoint : Int
    let level : Double
    let wallet : Int
    let imageUrl : String
}

extension TokenHTTPrequest {
    public func userProfile(Json json:NSDictionary) -> Profile {
        let login = json["login"] as? String ?? "N/A"
        let firstName = json["first_name"] as? String ?? "N/A"
        let lastName = json["last_name"] as? String ?? "N/A"
        let email = json["email"] as? String ?? "N/A"
        let correctionPoints = json["correction_point"] as? Int ?? -1
        var level = 0.0
        let wallet = json["wallet"] as? Int ?? -1
        let imgUrl = json["image_url"] as? String ?? "N/A"
        if let cursus = json["cursus_users"] as? [NSDictionary] {
            level = cursus[0]["level"] as? Double ?? 0.0
        }
        let profile = Profile(login: login, firstName: firstName, lastName: lastName, email: email, correctionPoint: correctionPoints, level: level, wallet: wallet, imageUrl: imgUrl)
        return profile
    }
}
