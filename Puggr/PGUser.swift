//
//  PGUser.swift
//  Puggr
//
//  Created by Michael Hulet on 9/30/16.
//  Copyright © 2016 Michael Hulet. All rights reserved.
//

import Foundation
import Locksmith

enum PGUserAuthKeys: String{
    case Username
    case Password
}

struct PGUser: CreateableSecureStorable, ReadableSecureStorable, GenericPasswordSecureStorable{
    static private let currentAccountKey = "current"
    let username: String
    let password: String
    let service = "Puggr"
    var account: String{
        get{
            return username
        }
    }
    var data: [String: Any]{
        get{
            return [PGUserAuthKeys.Username.rawValue: username, PGUserAuthKeys.Password.rawValue: password]
        }
    }
    func authenticate(password: String = "", completion: ((_ success: Bool) -> Void)?) throws -> Void{
        let success = true
        completion?(success)
        if success && readFromSecureStore() == nil{
            do{

            }
        }
    }
}
