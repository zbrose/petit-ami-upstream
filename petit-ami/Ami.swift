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
    @Persisted var name: String
    @Persisted var creationDate = Date()
    @Persisted var age: Int
    @Persisted var lvl: Int
    @Persisted var alive: Bool
    @Persisted var energy: Int
    @Persisted var hunger: Int
    @Persisted var thirst: Int
    @Persisted var happiness: Int
}
