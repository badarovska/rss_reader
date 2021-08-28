//
//  FeedTableViewCell.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//


import UIKit

class FeedTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FeedTableViewCell"
    private var separatorView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        textLabel?.numberOfLines = 0
        textLabel?.font = UIFont(name: "AvenirNext-Medium", size: 20)
        textLabel?.textColor = .black
        
        separatorView.backgroundColor = .systemGray4
        contentView.addSubview(separatorView)
        separatorView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(1)
            make.height.equalTo(1)
        }
    }
    
    func set(title: String) {
        textLabel?.text = title
    }
}
