//
//  Ami.swift
//  petit-ami
//
//  Created by Bryan Nguyen on 4/12/22.
//

import Foundation
import RealmSwift

class Ami: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name = ""
    @Persisted var creationDate = Date() // how can can we create the date
    @Persisted var age = 0
    @Persisted var lifeStage = "baby"
    @Persisted var lvl = 0
    @Persisted var alive = true
    @Persisted var energy = 100
    @Persisted var hunger = 100
    @Persisted var thirst = 100
    @Persisted var happiness = 100
}
