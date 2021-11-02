//
//  MainInteractor.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//  
//

import Foundation

final class MainInteractor {
	weak var output: MainInteractorOutput?
    var infoStorageService: InfoStorageProtocol?
}

extension MainInteractor: MainInteractorInput {
    func clearAll() {
        infoStorageService?.clearAll(completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.output?.clearAllSuccess()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func updatePersonalInfoName(personalId: String, name: String) {
        infoStorageService?.updatePersonalInfoName(personalId: personalId, name: name, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.output?.updatePersonalInfoNameSuccess()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func updatePersonalInfoAge(personalId: String, age: Int) {
        infoStorageService?.updatePersonalInfoAge(personalId: personalId, age: age, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.output?.updatePersonalInfoAgeSuccess()
            case .failure(let error):
                print(error.localizedDescription)
            }

        })
    }
    
    func fetchPersonalInfo() {
        infoStorageService?.fetchPersonalInfo(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.fetchPersonalInfoSuccess(data: data ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func createPersonalInfo() {
        infoStorageService?.createPersonalInfo(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.createPersonalInfoSuccess(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func createInfos() {
        infoStorageService?.createInfos(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.createInfosSuccess(data: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func updateInfosName(infoId: String, name: String) {
        infoStorageService?.updateInfosName(infoId: infoId, name: name, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.output?.updateInfosNameSuccess()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func updateInfosAge(infoId: String, age: Int) {
        infoStorageService?.updateInfosAge(infoId: infoId, age: age, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.output?.updateInfosAgeSuccess()
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func deleteInfos(infoId: String) {
        infoStorageService?.deleteInfos(infoId: infoId, completion: { [weak self] result in
            switch result {
            case .success(_):
                self?.output?.deleteInfosSuccess()
            case .failure(let error):
                print(error.localizedDescription)
            }

        })
    }
    
    func fetchInfos() {
        infoStorageService?.fetchInfos(completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.output?.fetchInfosResult(data: data ?? [])
            case .failure(let error):
                print(error.localizedDescription)
            }

        })
    }
    
    
}
