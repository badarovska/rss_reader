//
//  NewsFeedViewController.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import Foundation
import UIKit
import SnapKit
import FeedKit
import RxSwift

class NewsFeedViewController: UIViewController {
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()
    
    private var viewModel: NewsFeedViewModel!
    private var disposeBag = DisposeBag()
    
    init(viewModel: NewsFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupViews()
        setupBindings()
        viewModel.getFeed()
        viewModel.getCategory()
    }
    
    private func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.black
        
        tableView.separatorStyle = .none
        tableView.register(FeedTableViewCell.self,
                           forCellReuseIdentifier: FeedTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel.title
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .drive(loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.isLoading
            .map({!$0})
            .drive(loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.feed.drive(tableView.rx.items(cellIdentifier: FeedTableViewCell.reuseIdentifier,
                                                cellType: FeedTableViewCell.self)) { row, data, cell in
            cell.set(title: data.title ?? "")
        }.disposed(by: disposeBag)
    }
}
