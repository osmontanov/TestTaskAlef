//
//  MainViewLayout.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//

import UIKit
import SnapKit


class MainViewLayout: UIView {
    
    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collView.showsVerticalScrollIndicator = false
        collView.showsHorizontalScrollIndicator = false
        collView.translatesAutoresizingMaskIntoConstraints = false
        collView.backgroundColor = .clear
        collView.register(InfoCell.self)
        collView.register(InfoHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                          withReuseIdentifier: InfoHeaderCell.className)
        collView.register(InfoFooterCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                          withReuseIdentifier: InfoFooterCell.className)

        return collView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        addSubviews()
        addConstrainst()
    }
    
    private func addSubviews() {
        addSubview(mainCollectionView)
    }
    
    private func addConstrainst() {
        mainCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(safeArea.bottom)
        }
    }
}
