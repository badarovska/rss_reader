//
//  CategoriesProvider.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import Foundation
import RxSwift

protocol CategoriesProvider {
    func getCategories() -> Observable<[Category]>
}
