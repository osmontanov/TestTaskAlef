//
//  InfoFooterCell.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 2/11/21.
//

import UIKit
import SnapKit

protocol InfoFooterDelegate: AnyObject {
    func clearAll()
}


class InfoFooterCell: UICollectionReusableView {
    
    weak var delegate: InfoFooterDelegate? = nil
    
    private lazy var clearAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("    Очистить    ", for: .normal)
        button.tintColor = .red
        button.layer.borderColor = UIColor.red.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 50 / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(clearAllHandler), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(clearAllButton)
        clearAllButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalToSuperview().dividedBy(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func clearAllHandler() {
        delegate?.clearAll()
    }
}
