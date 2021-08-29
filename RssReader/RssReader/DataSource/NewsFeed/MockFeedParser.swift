//
//  MockFeedParser.swift
//  RssReaderTests
//
//  Created by WF | Gordana Badarovska on 29.8.21.
//

import Foundation
import FeedKit

class MockFeedParser: RSSParser {
    
    private func makeDemoItems() -> [RSSFeedItem] {
        let item1 = RSSFeedItem()
        item1.title = "Test 1"
        item1.link = "https://www.24sata.hr/feeds/aktualno.xml"
        
        let item2 = RSSFeedItem()
        item1.title = "Test 1"
        item1.link = "https://www.24sata.hr/feeds/aktualno.xml"

        let item3 = RSSFeedItem()
        item1.title = "Test 1"
        item1.link = "https://www.24sata.hr/feeds/aktualno.xml"

        let item4 = RSSFeedItem()
        item1.title = "Test 1"
        item1.link = "https://www.24sata.hr/feeds/aktualno.xml"

        return [item1, item2, item3, item4]
    }
    
    func parse() -> Result<[RSSFeedItem], ParserError> {
        let result = Result<[RSSFeedItem], ParserError>
            .success(makeDemoItems())
        return result
    }
    
    func parseAsync(callback: @escaping RSSParserCallback) {
        let result = Result<[RSSFeedItem], ParserError>
            .success(makeDemoItems())
        return callback(result)
    }
    
    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback) {
        let result = Result<[RSSFeedItem], ParserError>
            .success(makeDemoItems())
        return callback(result)
    }
    
    func abort() { }
}

class GenericFeedErrorParser: RSSParser {
    private let errorResult = Result<[RSSFeedItem], ParserError>
        .failure(ParserError.internalError(reason: "test"))
    
    func parse() -> Result<[RSSFeedItem], ParserError> {
        return errorResult
    }
    
    func parseAsync(callback: @escaping RSSParserCallback) {
        callback(errorResult)
    }
    
    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback) {
        callback(errorResult)
    }
    
    func abort() { }
}

class NoFeedErrorParser: RSSParser {
    private let errorResult = Result<[RSSFeedItem], ParserError>
        .failure(ParserError.feedNotFound)
    
    func parse() -> Result<[RSSFeedItem], ParserError> {
        return errorResult
    }
    
    func parseAsync(callback: @escaping RSSParserCallback) {
        callback(errorResult)
    }
    
    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback) {
        callback(errorResult)
    }
    
    func abort() { }
}

class EmptyFeedErrorParser: RSSParser {
    private let emptySuccess = Result<[RSSFeedItem], ParserError>
        .success([])
    
    func parse() -> Result<[RSSFeedItem], ParserError> {
        return emptySuccess
    }
    
    func parseAsync(callback: @escaping RSSParserCallback) {
        callback(emptySuccess)
    }
    
    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback) {
        callback(emptySuccess)
    }
    
    func abort() { }
}
