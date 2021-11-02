//
//  InfoStorageManager.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//

import Foundation
import RealmSwift


protocol InfoStorageProtocol {
    func updatePersonalInfoName(personalId: String, name: String, completion: @escaping(Result<PersonalRealmModel?, Error>) -> Void)
    func updatePersonalInfoAge(personalId: String, age: Int, completion: @escaping(Result<PersonalRealmModel?, Error>) -> Void)
    func fetchPersonalInfo(completion: @escaping (Result<[PersonalRealmModel]?, Error>) -> Void)
    func createPersonalInfo(completion: @escaping(Result<PersonalRealmModel, Error>) -> Void)
    func createInfos(completion: @escaping(Result<InfoRealmModel, Error>) -> Void)
    func updateInfosName(infoId: String, name: String, completion: @escaping(Result<InfoRealmModel?, Error>) -> Void)
    func updateInfosAge(infoId: String, age: Int, completion: @escaping(Result<InfoRealmModel?, Error>) -> Void)
    func deleteInfos(infoId: String, completion: @escaping(Result<InfoRealmModel?, Error>) -> Void)
    func fetchInfos(completion: @escaping (Result<[InfoRealmModel]?, Error>) -> Void)
    func clearAll(completion: @escaping (Result<Any?, Error>) -> Void)
}


class InfoStorageManager {
    private let queue = DispatchQueue(label: "infoStorageQueue")
}

extension InfoStorageManager: InfoStorageProtocol {
    func clearAll(completion: @escaping (Result<Any?, Error>) -> Void) {
        let realm = try? Realm()
        do {
            try realm?.write {
                realm?.deleteAll()
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
    }
    
    func updatePersonalInfoName(personalId: String, name: String, completion: @escaping(Result<PersonalRealmModel?, Error>) -> Void) {
        let realm = try? Realm()
        guard let infoForUpdate = realm?.objects(PersonalRealmModel.self).first(where: { info in
            info.id == personalId
        }) else {
            completion(.failure(CustomError.cannotUpdate))
            return
        }
        do {
            try realm?.write {
                infoForUpdate.name = name
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func updatePersonalInfoAge(personalId: String, age: Int, completion: @escaping(Result<PersonalRealmModel?, Error>) -> Void) {
        let realm = try? Realm()
        guard let infoForUpdate = realm?.objects(PersonalRealmModel.self).first(where: { info in
            info.id == personalId
        }) else {
            completion(.failure(CustomError.cannotUpdate))
            return
        }
        do {
            try realm?.write {
                infoForUpdate.age = age
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func fetchPersonalInfo(completion: @escaping (Result<[PersonalRealmModel]?, Error>) -> Void) {
        
        let realm = try? Realm()
        if let realmLists = realm?.objects(PersonalRealmModel.self) {
            let lists = realmLists.toArray(ofType: PersonalRealmModel.self)
            completion(.success(lists))
        } else {
            completion(.failure(CustomError.cannotFetch))
        }
        
    }
    
    func createPersonalInfo(completion: @escaping(Result<PersonalRealmModel, Error>) -> Void) {
        
        let realm = try? Realm()
        let newInfoModel = PersonalRealmModel()
        do {
            try realm?.write {
                realm?.add(newInfoModel)
            }
            completion(.success(newInfoModel))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func createInfos(completion: @escaping(Result<InfoRealmModel, Error>) -> Void) {
        
        let realm = try? Realm()
        let newInfoModel = InfoRealmModel()
        do {
            try realm?.write {
                realm?.add(newInfoModel)
            }
            completion(.success(newInfoModel))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func updateInfosName(infoId: String, name: String, completion: @escaping(Result<InfoRealmModel?, Error>) -> Void) {
        
        let realm = try? Realm()
        guard let infoForUpdate = realm?.objects(InfoRealmModel.self).first(where: { info in
            info.id == infoId
        }) else {
            completion(.failure(CustomError.cannotUpdate))
            return
        }
        do {
            try realm?.write {
                infoForUpdate.name = name
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func updateInfosAge(infoId: String, age: Int, completion: @escaping(Result<InfoRealmModel?, Error>) -> Void) {
        
        let realm = try? Realm()
        guard let infoForUpdate = realm?.objects(InfoRealmModel.self).first(where: { info in
            info.id == infoId
        }) else {
            completion(.failure(CustomError.cannotUpdate))
            return
        }
        do {
            try realm?.write {
                infoForUpdate.age = age
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func deleteInfos(infoId: String, completion: @escaping(Result<InfoRealmModel?, Error>) -> Void) {
        
        let realm = try? Realm()
        guard let infoForDelete = realm?.objects(InfoRealmModel.self).first(where: { info in
            info.id == infoId
        }) else {
            completion(.failure(CustomError.cannotDelete))
            return
        }
        do {
            try realm?.write {
                realm?.delete(infoForDelete)
            }
            completion(.success(nil))
        } catch {
            completion(.failure(error))
        }
        
    }
    
    func fetchInfos(completion: @escaping (Result<[InfoRealmModel]?, Error>) -> Void) {
        
        let realm = try? Realm()
        if let realmLists = realm?.objects(InfoRealmModel.self) {
            let lists = realmLists.toArray(ofType: InfoRealmModel.self)
            completion(.success(lists))
        } else {
            completion(.failure(CustomError.cannotFetch))
        }
        
        
    }
}
