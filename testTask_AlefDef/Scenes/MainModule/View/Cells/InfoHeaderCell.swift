//
//  InfoHeaderCell.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//

import UIKit
import SnapKit


class InfoHeaderCell: UICollectionReusableView, UITextFieldDelegate {
    
    weak var delegate: InfoCellDelegate? = nil
    private var id = ""
    
    private lazy var personalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "Персональные данные"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
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
        stack.spacing = 20
        stack.alignment = .fill
        return stack
    }()
    
    private lazy var kidsAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "Дети (макс. 5)"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private lazy var addKidButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("    + Добавить Ребенка    ", for: .normal)
        button.layer.cornerRadius = 50 / 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addKidHandler), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func hideAddKidButton(isHidden: Bool) {
        addKidButton.isHidden = isHidden
    }
    
    func setupData(data: PersonalRealmModel) {
        id = data.id
        nameTextField.textField.text = data.name
        if data.age != 0 {
            ageTextField.textField.text = "\(data.age)"
        }
    }
    
    //MARK: - UIActions
    
    @objc
    private func addKidHandler() {
        delegate?.addKid()
    }
    
    private func configure() {
        backgroundColor = .clear
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        addSubview(personalInfoLabel)
        addSubview(textFieldStack)
        addSubview(kidsAmountLabel)
        addSubview(addKidButton)
    }
    
    private func addConstraints() {
        personalInfoLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        textFieldStack.snp.makeConstraints { make in
            make.top.equalTo(personalInfoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        kidsAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(textFieldStack.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.height.equalTo(50)
        }
        addKidButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.leading.equalTo(kidsAmountLabel.snp.trailing)
            make.height.equalTo(50)
            make.center.equalTo(kidsAmountLabel)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTextField.textField {
            delegate?.nameData(type: .personalInfo, id: id, text: textField.text ?? "")
        } else {
            delegate?.ageData(type: .personalInfo, id: id, num: Int(textField.text ?? "") ?? 0)
        }
    }
}
