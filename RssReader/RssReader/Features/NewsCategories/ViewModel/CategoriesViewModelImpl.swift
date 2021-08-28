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

    private var errorSubject: PublishSubject<Bool> = PublishSubject()
    private var loadingSubject: PublishSubject<Bool> = PublishSubject()
    private var categoriesSubject: PublishSubject<[Category]> = PublishSubject()
    
    var error: Driver<Bool> {
        return errorSubject.asDriver(onErrorJustReturn: true)
    }
    
    var loading: Driver<Bool> {
        return loadingSubject.asDriver(onErrorJustReturn: false)
    }
    
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
        loadingSubject.onNext(true)
                
        categoriesDisposable = categoriesProvider.getCategories()
            .subscribe { [unowned self] categories in
                self.categoriesSubject.onNext(categories)
            } onError: { [unowned self] error in
                self.errorSubject.onNext(true)
            }
    }
}
