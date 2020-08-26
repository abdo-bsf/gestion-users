//
//  User.swift
//  Gestion Users
//
//  Created by basafou on 8/25/20.
//  Copyright © 2020 basafou. All rights reserved.
//

import Foundation

class User {
    var id:Int
    var name:String
    var username:String
    var email:String
    
    init(id:Int,name:String,username:String,email:String) {
        self.id = id
        self.name = name
        self.email = email
        self.username = username
    }
}
