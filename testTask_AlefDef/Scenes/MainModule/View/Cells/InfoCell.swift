//
//  InfoCell.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//

import UIKit
import SnapKit

enum InfoType {
    case personalInfo, info
}

protocol InfoCellDelegate: AnyObject {
    func nameData(type:InfoType, id: String?, text: String)
    func ageData(type:InfoType, id: String?, num: Int)
    func addKid()
    func deleteKidInfo(indexPath: IndexPath)
}


class InfoCell: UICollectionViewCell, UITextFieldDelegate {
    
    weak var delegate: InfoCellDelegate? = nil
    private var id = ""
    private var indexPath: IndexPath?
    
    private lazy var nameTextField: CustomTextField = {
        let textF = CustomTextField()
        textF.topLabel.text = "Имя"
        textF.textField.placeholder = "Вова"
        textF.textField.delegate = self
        return textF
    }()
    
    private lazy var ageTextField: CustomTextField = {
        let textF = CustomTextField()
        textF.topLabel.text = "Возраст"
        textF.textField.placeholder = "22"
        textF.textField.keyboardType = .numberPad
        textF.textField.delegate = self
        return textF
    }()
    
    private lazy var textFieldStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameTextField, ageTextField])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 20
        return stack
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.alpha = 0.1
        view.backgroundColor = .black
        return view
    }()
    
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.addTarget(self, action: #selector(deleteHandler), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIActions
    
    @objc
    private func deleteHandler() {
        if let indexPath = indexPath {
            delegate?.deleteKidInfo(indexPath: indexPath)
        }
    }
    
    //MARK: - Helpers
    
    func setupData(data: InfoRealmModel, indexPath: IndexPath) {
        self.id = data.id
        self.indexPath = indexPath
        nameTextField.textField.text = data.name
        if data.age != 0 {
            ageTextField.textField.text = "\(data.age)"
        } else {
            ageTextField.textField.text = ""
        }
    }
    
    private func configure() {
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(textFieldStack)
        contentView.addSubview(deleteButton)
        addSubview(bottomLine)
    }
    
    private func addConstraints() {
        textFieldStack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(150)
        }
        deleteButton.snp.makeConstraints { make in
            make.leading.equalTo(textFieldStack.snp.trailing)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField.textField {
            delegate?.nameData(type: .info, id: id, text: textField.text ?? "")
        } else {
            delegate?.ageData(type: .info, id: id, num: Int(textField.text ?? "") ?? 0)
        }
    }
}
