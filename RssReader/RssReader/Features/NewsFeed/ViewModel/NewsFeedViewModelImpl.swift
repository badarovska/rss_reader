//
//  NewsFeedViewModelImpl.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import Foundation
import RxSwift
import RxCocoa
import FeedKit



class NewsFeedViewModelImpl: NewsFeedViewModel {
    
    private var feedProvider: RSSParser!
    private var categoryTitle: String!

    private var errorSubject: PublishSubject<String> = PublishSubject()
    private var loadingSubject: PublishSubject<Bool> = PublishSubject()
    private var feedSubject: PublishSubject<[RSSFeedItem]> = PublishSubject()
    private var titleSubject: PublishSubject<String> = PublishSubject()

    var error: Driver<String> {
        return errorSubject.asDriver(onErrorJustReturn: "")
    }
    
    var isLoading: Driver<Bool> {
        return loadingSubject.asDriver(onErrorJustReturn: false)
    }
    
    var feed: Driver<[RSSFeedItem]> {
        return feedSubject.asDriver(onErrorJustReturn: [])
    }
    
    var title: Driver<String> {
        return titleSubject.asDriver(onErrorJustReturn: "")
    }
    
    init(categoryTitle: String, feedProvider: RSSParser) {
        self.categoryTitle = categoryTitle
        self.feedProvider = feedProvider
    }
    
    deinit {
        feedProvider.abort()
    }
    
    func getCategory() {
        titleSubject.onNext(categoryTitle)
    }
    
    func getFeed() {
        loadingSubject.onNext(true)
                
        feedProvider.parseAsync { [weak self] result in
            switch result {
            case .success(let feed):
                if feed.isEmpty {
                    let errorMessage = NewsFeedError.noFeedError.rawValue
                    self?.errorSubject.onNext(errorMessage)
                } else {
                    self?.feedSubject.onNext(feed)
                    self?.loadingSubject.onNext(false)
                }
            case .failure(let error):
                switch  error {
                case .feedNotFound:
                    let errorMessage = NewsFeedError.noFeedError.rawValue
                    self?.errorSubject.onNext(errorMessage)
                default:
                    let errorMessage = NewsFeedError.genericError.rawValue
                    self?.errorSubject.onNext(errorMessage)
                }
                self?.loadingSubject.onNext(false)
            }
        }
    }
}
