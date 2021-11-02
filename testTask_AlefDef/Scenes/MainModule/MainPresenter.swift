//
//  MainPresenter.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//  
//

import Foundation

final class MainPresenter {
	weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?
    
	private let router: MainRouterInput
	private let interactor: MainInteractorInput
    private var deleteInfoIndexPath: IndexPath?
    
    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainModuleInput {
}

extension MainPresenter: MainViewOutput {
    func clearAll() {
        router.showAlert { [weak self] in
            self?.interactor.clearAll()
        }
    }
    
    func updatePersonalInfoName(personalId: String, name: String) {
        interactor.updatePersonalInfoName(personalId: personalId, name: name)
    }
    
    func updatePersonalInfoAge(personalId: String, age: Int) {
        interactor.updatePersonalInfoAge(personalId: personalId, age: age)
    }
    
    func fetchPersonalInfo() {
        interactor.fetchPersonalInfo()
    }
    
    func createPersonalInfo() {
        interactor.createPersonalInfo()
    }
    
    func createInfos() {
        interactor.createInfos()
    }
    
    func updateInfosName(infoId: String, name: String) {
        interactor.updateInfosName(infoId: infoId, name: name)
    }
    
    func updateInfosAge(infoId: String, age: Int) {
        interactor.updateInfosAge(infoId: infoId, age: age)
    }
    
    func deleteInfos(infoId: String, indexPath: IndexPath) {
        self.deleteInfoIndexPath = indexPath
        interactor.deleteInfos(infoId: infoId)
    }
    
    func fetchInfos() {
        interactor.fetchInfos()
    }
    
}

extension MainPresenter: MainInteractorOutput {
    func clearAllSuccess() {
        view?.clearAllSuccess()
    }
    
    func updatePersonalInfoNameSuccess() {
        view?.updatePersonalInfoNameSuccess()
    }
    
    func updatePersonalInfoAgeSuccess() {
        view?.updatePersonalInfoAgeSuccess()
    }
    
    func fetchPersonalInfoSuccess(data: [PersonalRealmModel]) {
        if data.count == 0 {
            interactor.createPersonalInfo()
        } else {
            view?.fetchPersonalInfoSuccess(data: data)
        }
    }
    
    func createPersonalInfoSuccess(data: PersonalRealmModel) {
        view?.createPersonalInfoSuccess(data: data)
    }
    
    func createInfosSuccess(data: InfoRealmModel) {
        view?.createInfosSuccess(data: data)
    }
    
    func updateInfosNameSuccess() {
        view?.updateInfosNameSuccess()
    }
    
    func updateInfosAgeSuccess() {
        view?.updateInfosAgeSuccess()
    }
    
    func deleteInfosSuccess() {
        if let indexPath = deleteInfoIndexPath {
            view?.deleteInfosSuccess(indexPath: indexPath)
        }
    }
    
    func fetchInfosResult(data: [InfoRealmModel]) {
        view?.fetchInfosResult(data: data)
    }
    
}
