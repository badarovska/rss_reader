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

    private var errorSubject: PublishSubject<Bool> = PublishSubject()
    private var loadingSubject: PublishSubject<Bool> = PublishSubject()
    private var feedSubject: PublishSubject<[RSSFeedItem]> = PublishSubject()
    
    var error: Driver<Bool> {
        return errorSubject.asDriver(onErrorJustReturn: true)
    }
    
    var isLoading: Driver<Bool> {
        return loadingSubject.asDriver(onErrorJustReturn: false)
    }
    
    var feed: Driver<[RSSFeedItem]> {
        return feedSubject.asDriver(onErrorJustReturn: [])
    }
    
    init(feedProvider: RSSParser) {
        self.feedProvider = feedProvider
    }
    
    deinit {
        feedProvider.abort()
    }
    
    func getFeed() {
        loadingSubject.onNext(true)
                
        feedProvider.parseAsync { [weak self] result in
            switch result {
            case .success(let feed):
                self?.feedSubject.onNext(feed)
                self?.loadingSubject.onNext(false)
            case .failure(_):
                self?.errorSubject.onNext(true)
                self?.loadingSubject.onNext(false)
            }
        }
    }
}
