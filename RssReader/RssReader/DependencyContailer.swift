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

protocol NewsFeedFactory {
    func makeNewsFeedProvider(for url: URL) -> RSSParser
    func makeNewsFeedViewModel(for category: Category) -> NewsFeedViewModel
    func makeNewsFeedViewController(for category: Category) -> NewsFeedViewController
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
        let categoriesController = CategoriesViewController(viewModel: viewModel,
                                                            newsFeedFactory: self)
        return categoriesController
    }
}

extension DependencyContainer: NewsFeedFactory {
    func makeNewsFeedProvider(for url: URL) -> RSSParser {
        return FeedKitParser(url: url)
    }
    
    func makeNewsFeedViewModel(for category: Category) -> NewsFeedViewModel {
        let feedProvider = makeNewsFeedProvider(for: category.rssURL)
        let viewModel = NewsFeedViewModelImpl(categoryTitle: category.title,
                                              feedProvider: feedProvider)
        return viewModel
    }
    
    func makeNewsFeedViewController(for category: Category) -> NewsFeedViewController {
        let viewModel = makeNewsFeedViewModel(for: category)
        return NewsFeedViewController(viewModel: viewModel)
    }
}
