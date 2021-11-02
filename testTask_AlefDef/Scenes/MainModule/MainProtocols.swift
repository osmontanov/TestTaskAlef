//
//  MainProtocols.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//  
//

import Foundation

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
}

protocol MainModuleOutput: AnyObject {
}

protocol MainViewInput: AnyObject {
    func updatePersonalInfoNameSuccess()
    func updatePersonalInfoAgeSuccess()
    func fetchPersonalInfoSuccess(data: [PersonalRealmModel])
    func createPersonalInfoSuccess(data: PersonalRealmModel)
    func createInfosSuccess(data: InfoRealmModel)
    func updateInfosNameSuccess()
    func updateInfosAgeSuccess()
    func deleteInfosSuccess(indexPath: IndexPath)
    func fetchInfosResult(data: [InfoRealmModel])
    func clearAllSuccess()
}

protocol MainViewOutput: AnyObject {
    func clearAll()
    func updatePersonalInfoName(personalId: String, name: String)
    func updatePersonalInfoAge(personalId: String, age: Int)
    func fetchPersonalInfo()
    func createPersonalInfo()
    func createInfos()
    func updateInfosName(infoId: String, name: String)
    func updateInfosAge(infoId: String, age: Int)
    func deleteInfos(infoId: String, indexPath: IndexPath)
    func fetchInfos()
}

protocol MainInteractorInput: AnyObject {
    func clearAll()
    func updatePersonalInfoName(personalId: String, name: String)
    func updatePersonalInfoAge(personalId: String, age: Int)
    func fetchPersonalInfo()
    func createPersonalInfo()
    func createInfos()
    func updateInfosName(infoId: String, name: String)
    func updateInfosAge(infoId: String, age: Int)
    func deleteInfos(infoId: String)
    func fetchInfos()
}

protocol MainInteractorOutput: AnyObject {
    func updatePersonalInfoNameSuccess()
    func updatePersonalInfoAgeSuccess()
    func fetchPersonalInfoSuccess(data: [PersonalRealmModel])
    func createPersonalInfoSuccess(data: PersonalRealmModel)
    func createInfosSuccess(data: InfoRealmModel)
    func updateInfosNameSuccess()
    func updateInfosAgeSuccess()
    func deleteInfosSuccess()
    func fetchInfosResult(data: [InfoRealmModel])
    func clearAllSuccess()
}

protocol MainRouterInput: AnyObject {
    func showAlert(completion: @escaping() -> Void)
}
