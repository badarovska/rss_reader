//
//  CategoryViewModel.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import Foundation
import RxCocoa

protocol CategoriesViewModel {
    var categories: Driver<[Category]> { get }
    
    func getCategories() 
}
