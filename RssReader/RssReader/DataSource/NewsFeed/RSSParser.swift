//
//  RssParser.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import Foundation
import FeedKit

typealias RSSParserCallback = (Result<RSSFeed?, ParserError>) -> Void

protocol RSSParser {
    func parse() -> Result<RSSFeed?, ParserError>
    func parseAsync(callback: @escaping RSSParserCallback)
    func parseAsync(queue: DispatchQueue, callback: @escaping RSSParserCallback)
    func abort()
}

