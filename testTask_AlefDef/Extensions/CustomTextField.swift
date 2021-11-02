//
//  CustomTextField.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//

import UIKit
import SnapKit

class CustomTextField: UIView {

    var textField: UITextField = {

        let textView = UITextField()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.keyboardType = UIKeyboardType.default
        textView.borderStyle = .none
        textView.returnKeyType = UIReturnKeyType.done
        textView.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textView

    }()
    
    var topLabel: UILabel = {

        let topLabel = UILabel()
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.textAlignment = .left
        topLabel.font = UIFont.systemFont(ofSize: 16)
        topLabel.textColor = .darkGray
        topLabel.numberOfLines = 1
        return topLabel

    }()
    
    private lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [topLabel, textField])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 5
        clipsToBounds = true
        addSubview(stack)
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
