//
//  CategoriesViewController.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import UIKit
import RxCocoa
import RxSwift

class CategoriesViewController: UIViewController {
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
    
    private var viewModel: CategoriesViewModel!
    private let categories: [Category] = []
    private let disposeBag = DisposeBag()
    
    init(viewModel: CategoriesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupViews()
        setupBindings()
        viewModel.getCategories()
    }
    
    private func setupViews() {
        title = "News"
        view.backgroundColor = .white

        collectionView.backgroundColor = .white
        collectionView.register(CategoriesCollectionViewCell.self,
                                forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseIdentifier)
        _ = collectionView.rx.setDelegate(self)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBindings() {
        viewModel.loading
            .drive(loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.loading
            .drive(loadingIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.categories
            .drive(collectionView.rx.items(cellIdentifier: CategoriesCollectionViewCell.reuseIdentifier, cellType: CategoriesCollectionViewCell.self)) {  row, data, cell in
                cell.set(title: data.title)
            }.disposed(by: disposeBag)
    }
}

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let interitemSpacing = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0
        let cellSize = (width - interitemSpacing) / 2
        return CGSize(width: cellSize, height: cellSize)
    }
}
