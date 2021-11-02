//
//  PersonalRealmModel.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//

import RealmSwift

class PersonalRealmModel: Object {
    @objc dynamic var id: String = NSUUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
