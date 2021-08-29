//
//  RssReaderTests.swift
//  RssReaderTests
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
import  FeedKit

@testable import RssReader

class NewsFeedViewModelTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var sut: NewsFeedViewModel!
    
    let testCategory = Category(title: "Aktualno",
                                rssURL: URL(string: "https://www.24sata.hr/feeds/aktualno.xml")!)
    
    override func setUpWithError() throws {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()


        sut = NewsFeedViewModelImpl(categoryTitle: testCategory.title,
                                    feedProvider: MockFeedParser())

    }

    override func tearDownWithError() throws {
        super.tearDown()
        scheduler = nil
        disposeBag = nil
        sut = nil
    }

    func testCategoryTitle() {
        let observer: TestableObserver<String> = scheduler.createObserver(String.self)
        let expextedTitle = Recorded.events(.next(0, testCategory.title))

        
        sut.title
            .drive(observer)
            .disposed(by: disposeBag)
        sut.getCategory()
        
        scheduler.start()

        XCTAssertEqual(expextedTitle, observer.events)
    }
    
    func testGenericError() {
        sut = NewsFeedViewModelImpl(categoryTitle: testCategory.title,
                                    feedProvider: GenericFeedErrorParser())
        
        let observer: TestableObserver<String> = scheduler.createObserver(String.self)
        let expextedTitle = Recorded.events(.next(0, NewsFeedError.genericError.rawValue))
        
        sut.error
            .drive(observer)
            .disposed(by: disposeBag)
        sut.getFeed()
        
        scheduler.start()
        
        XCTAssertEqual(expextedTitle, observer.events)
    }
    
    func testNoFeedError() {
        sut = NewsFeedViewModelImpl(categoryTitle: testCategory.title,
                                    feedProvider: NoFeedErrorParser())
        
        let observer: TestableObserver<String> = scheduler.createObserver(String.self)
        let expextedTitle = Recorded.events(.next(0, NewsFeedError.noFeedError.rawValue))
        
        sut.error
            .drive(observer)
            .disposed(by: disposeBag)
        sut.getFeed()
        
        scheduler.start()
        
        XCTAssertEqual(expextedTitle, observer.events)
    }
    
    func testEmptyFeedError() {
        sut = NewsFeedViewModelImpl(categoryTitle: testCategory.title,
                                    feedProvider: EmptyFeedErrorParser())
        
        let observer: TestableObserver<String> = scheduler.createObserver(String.self)
        let expextedTitle = Recorded.events(.next(0, NewsFeedError.noFeedError.rawValue))
        
        sut.error
            .drive(observer)
            .disposed(by: disposeBag)
        sut.getFeed()
        
        scheduler.start()
        
        XCTAssertEqual(expextedTitle, observer.events)
    }
    
    func testLoadingWithSuccess() {
        let observer: TestableObserver<Bool> = scheduler.createObserver(Bool.self)
        let expextedValues = Recorded.events([.next(0, true), .next(0, false)])
        
        sut.isLoading
            .drive(observer)
            .disposed(by: disposeBag)
        sut.getFeed()
        
        scheduler.start()

        XCTAssertEqual(expextedValues, observer.events)
    }
    
    func testLoadingWithError() {
        sut = NewsFeedViewModelImpl(categoryTitle: testCategory.title,
                                    feedProvider: NoFeedErrorParser())

        let observer: TestableObserver<Bool> = scheduler.createObserver(Bool.self)
        let expextedValues = Recorded.events([.next(0, true), .next(0, false)])
        
        sut.isLoading
            .drive(observer)
            .disposed(by: disposeBag)
        sut.getFeed()
        
        scheduler.start()
        
        XCTAssertEqual(expextedValues, observer.events)
    }
    
    func testFeedNotEmpty() {
        let observer: TestableObserver<[RSSFeedItem]> = scheduler.createObserver([RSSFeedItem].self)

        sut.feed
            .drive(observer)
            .disposed(by: disposeBag)
        sut.getFeed()

        scheduler.start()
        
        XCTAssertFalse(observer.events.first!.value.element!.isEmpty)
    }

}
