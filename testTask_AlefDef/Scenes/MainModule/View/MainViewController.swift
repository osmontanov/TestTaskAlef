//
//  MainViewController.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//  
//

import UIKit
import SwiftUI

final class MainViewController: UIViewController {
    var output: MainViewOutput?
    private lazy var contentView = MainViewLayout()
    private var header: InfoHeaderCell = InfoHeaderCell()
    var personalModel: PersonalRealmModel? = PersonalRealmModel() {
        didSet {
            contentView.mainCollectionView.reloadData()
        }
    }
    var infoModel = InfoRealmModel()
    private var kidsInfos = [InfoRealmModel]() {
        didSet {
            self.contentView.mainCollectionView.reloadData()
        }
    }
    
    //MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        view = contentView
        delegates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output?.fetchPersonalInfo()
        output?.fetchInfos()
    }
    
    //MARK: - Helpers
    
    private func checkForKidsCount() {
        if kidsInfos.count >= 5 {
            header.hideAddKidButton(isHidden: true)
        } else {
            header.hideAddKidButton(isHidden: false)
        }
    }
    
    //MARK: - Configure
    
    private func delegates() {
        contentView.mainCollectionView.delegate = self
        contentView.mainCollectionView.dataSource = self
    }
}

//MARK: - MainViewInput

extension MainViewController: MainViewInput {
    func clearAllSuccess() {
        output?.fetchPersonalInfo()
        output?.fetchInfos()
    }
    
    func updatePersonalInfoNameSuccess() {
        print("PersonalnameSuccess")
    }
    
    func updatePersonalInfoAgeSuccess() {
        print("personalAgeSuccess")
    }
    
    func fetchPersonalInfoSuccess(data: [PersonalRealmModel]) {
        self.personalModel = data.first
    }
    
    func createPersonalInfoSuccess(data: PersonalRealmModel) {
        self.personalModel = data
    }
    
    func createInfosSuccess(data: InfoRealmModel) {
        self.kidsInfos.append(data)
    }
    
    func updateInfosNameSuccess() {
        print("InfosnameSuccess")
    }
    
    func updateInfosAgeSuccess() {
        print("InfosAgeSuccess")
    }
    
    func deleteInfosSuccess(indexPath: IndexPath) {
        self.kidsInfos.remove(at: indexPath.row)
    }
    
    func fetchInfosResult(data: [InfoRealmModel]) {
        self.kidsInfos = data
    }
    
    
}

//MARK: - InfoFooterDelegate

extension MainViewController: InfoFooterDelegate {
    func clearAll() {
        output?.clearAll()
    }
}

//MARK: - InfoCellDelegate

extension MainViewController: InfoCellDelegate {
    func deleteKidInfo(indexPath: IndexPath) {
        output?.deleteInfos(infoId: kidsInfos[indexPath.row].id, indexPath: indexPath)
    }
    
    func addKid() {
        if kidsInfos.count < 5 {
            output?.createInfos()
        }
    }
    
    func nameData(type: InfoType, id: String?, text: String) {
        switch type {
        case .personalInfo:
            if let id = id {
                output?.updatePersonalInfoName(personalId: id, name: text)
            }
        case .info:
            if let id = id {
                output?.updateInfosName(infoId: id, name: text)
            }
        }
    }
    
    func ageData(type: InfoType, id: String?, num: Int) {
        switch type {
        case .personalInfo:
            if let id = id {
                output?.updatePersonalInfoAge(personalId: id, age: num)
            }
        case .info:
            if let id = id {
                output?.updateInfosAge(infoId: id, age: num)
            }
        }
    }
}

//MARK: - UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        checkForKidsCount()
        return kidsInfos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: InfoCell.self, for: indexPath)
        cell.setupData(data: kidsInfos[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            
            header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoHeaderCell.className, for: indexPath) as! InfoHeaderCell
            if let data = personalModel {
                header.setupData(data: data)
            }
            header.delegate = self
            return header
            
        case UICollectionView.elementKindSectionFooter:
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: InfoFooterCell.className, for: indexPath) as? InfoFooterCell else {return UICollectionReusableView()}
            footer.delegate = self
            return footer
            
        default:
            return UICollectionReusableView()
        }
    }
    
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

//MARK: - UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: contentView.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
