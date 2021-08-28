//
//  FeedKitParser.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import Foundation
import FeedKit

class FeedKitParser: RSSParser {
    private var parser: FeedParser
    
    init(url: URL) {
        parser = FeedParser(URL: url)
    }
    
    deinit {
        parser.abortParsing()
    }
    
    func parse() -> Result<RSSFeed?, ParserError> {
        let result = parser.parse()
        switch result {
        case .success(let feed):
            return .success(feed.rssFeed)
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func parseAsync(callback: @escaping RSSParserCallback) {
        parser.parseAsync { result in
            switch result {
            case .success(let feed):
                let success = Result<RSSFeed?, ParserError>.success(feed.rssFeed)
                return callback(success)
            case .failure(let error):
                let failure = Result<RSSFeed?, ParserError>.failure(error)
                return callback(failure)
            }
        }
    }

    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback) {
        parser.parseAsync(queue: queue) { result in
            switch result {
            case .success(let feed):
                let success = Result<RSSFeed?, ParserError>.success(feed.rssFeed)
                return callback(success)
            case .failure(let error):
                let failure = Result<RSSFeed?, ParserError>.failure(error)
                return callback(failure)
            }
        }
    }
    
    func abort() {
        parser.abortParsing()
    }
}
