//
//  API42Delegate.swift
//  Companion
//
//  Created by Mbongeni NDLOVU on 2018/10/18.
//  Copyright © 2018 mndlovu. All rights reserved.
//

import Foundation

/*
 A protocol defines a blueprint of methods, properties, and other requirements that suit a
 particular task or piece of functionality. The protocol can then be adopted by a class
 */
public protocol API42Delegate: class {
    func handleUser(User user:UserInfo)
    func handleError(Errors error: String)
}
