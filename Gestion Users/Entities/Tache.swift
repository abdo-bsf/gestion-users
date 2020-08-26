//
//  Tache.swift
//  Gestion Users
//
//  Created by basafou on 8/25/20.
//  Copyright © 2020 basafou. All rights reserved.
//

import Foundation

class Tache {
    var id:Int
    var title:String
    var completed:Bool
    
    init(id:Int,title:String,completed:Bool) {
        self.id = id
        self.title = title
        self.completed = completed
    }
}
