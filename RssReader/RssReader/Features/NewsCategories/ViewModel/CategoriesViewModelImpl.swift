//
//  CategoriesViewModelImpl.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//
import Foundation
import RxSwift
import RxCocoa

class CabtegoriesViewModelImpl: CategoriesViewModel {
    
    private var categoriesProvider: CategoriesProvider!
    private var categoriesDisposable: Disposable?

    private var categoriesSubject: PublishSubject<[Category]> = PublishSubject()

    var categories: Driver<[Category]> {
        return categoriesSubject.asDriver(onErrorJustReturn: [])
    }
        
    init(categoriesProvider: CategoriesProvider) {
        self.categoriesProvider = categoriesProvider
    }
    
    deinit {
        categoriesDisposable?.dispose()
    }
    
    func getCategories() {
        let categories = categoriesProvider.getCategories()
        categoriesSubject.onNext(categories)
    }
}
