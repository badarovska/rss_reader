//
//  CategoriesViewModelImpl.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//
import Foundation
import RxSwift

class CabtegoriesViewModelImpl: CategoriesViewModel {
    
    var error: PublishSubject<Error> = PublishSubject()
    var loading: PublishSubject<Bool> = PublishSubject()
    var categories: PublishSubject<[Category]> = PublishSubject()
    
    private var categoriesProvider: CategoriesProvider!
    private var categoriesDisposable: Disposable?
    
    init(categoriesProvider: CategoriesProvider) {
        self.categoriesProvider = categoriesProvider
    }
    
    deinit {
        categoriesDisposable?.dispose()
    }
    
    func getCategories() {
        loading.onNext(true)
        
        categoriesDisposable = categoriesProvider.getCategories()
            .subscribe { [unowned self] categories in
                self.categories.onNext(categories)
            } onError: { [unowned self] error in
                self.error.onNext(error)
            }
    }
}
