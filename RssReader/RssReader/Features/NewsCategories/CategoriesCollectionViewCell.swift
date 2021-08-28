//
//  CategoriesCollectionViewCell.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import UIKit
import SnapKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "CategoriesCollectionViewCell"
    
    private var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        titleLabel.numberOfLines = 0
        
        titleLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)
        titleLabel.textAlignment = .center

        titleLabel.textColor = UIColor.black
        titleLabel.backgroundColor = .white
        
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.systemGray4.cgColor
        titleLabel.layer.cornerRadius = 5
        titleLabel.clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().inset(5)
        }
    }
    
    func set(title: String) {
        titleLabel.text = title
    }
}
