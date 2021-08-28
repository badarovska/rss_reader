//
//  RssParser.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import Foundation
import FeedKit
import RxSwift

typealias RSSParserCallback = (Result<[RSSFeedItem], ParserError>) -> Void

protocol RSSParser {
    func parse() -> Result<[RSSFeedItem], ParserError>
    func parseAsync(callback: @escaping RSSParserCallback)
    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback)
    func abort()
}

