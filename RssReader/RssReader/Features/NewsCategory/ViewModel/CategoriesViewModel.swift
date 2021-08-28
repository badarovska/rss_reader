//
//  CategoryViewModel.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import Foundation
import RxSwift

protocol CategoriesViewModel {
    var error: PublishSubject<Error> { get }
    var loading: PublishSubject<Bool> { get }
    var categories: PublishSubject<[Category]> { get }
    
    func getCategories() 
}
