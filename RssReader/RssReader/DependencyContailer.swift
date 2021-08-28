//
//  DependancyContailer.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import Foundation

protocol CategoriesFactory {
    func makeCategoriesProvider() -> CategoriesProvider
    func makeCategoryViewModel() -> CategoriesViewModel
    func makeCategoriesViewController() -> CategoriesViewController
}

class DependencyContainer { }

extension DependencyContainer: CategoriesFactory {
    func makeCategoriesProvider() -> CategoriesProvider {
        return DefaultCagegoriesProvider()
    }
    
    func makeCategoryViewModel() -> CategoriesViewModel {
        let dataProvider = makeCategoriesProvider()
        return CabtegoriesViewModelImpl(categoriesProvider: dataProvider)
    }

    func makeCategoriesViewController() -> CategoriesViewController {
        let viewModel = makeCategoryViewModel()
        return CategoriesViewController(viewModel: viewModel)
    }
}
