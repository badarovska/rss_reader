//
//  HardcodedCategoriesProvider.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 27.8.21.
//

import Foundation
import RxSwift

class HardcodedCagegoriesProvider: CategoriesProvider {
    func getCategories() -> Observable<[Category]> {
        
        let popular = Category(title: "Aktualno",
                               rssURL: URL(string: "https://www.24sata.hr/feeds/aktualno.xml")!)
        
        let latest = Category(title: "Najnovije",
                              rssURL: URL(string: "https://www.24sata.hr/feeds/najnovije.xml")!)
        
        let news = Category(title: "News",
                            rssURL: URL(string: "https://www.24sata.hr/feeds/news.xml")!)
        
        let show = Category(title: "News",
                            rssURL: URL(string: "https://www.24sata.hr/feeds/show.xml")!)
        
        let sport = Category(title: "Sport",
                             rssURL: URL(string: "https://www.24sata.hr/feeds/sport.xml")!)
        
        let lifestyle = Category(title: "Lifestyle",
                                 rssURL: URL(string: "https://www.24sata.hr/feeds/lifestyle.xml")!)
        
        let tech = Category(title: "Tech",
                            rssURL: URL(string: "https://www.24sata.hr/feeds/tech.xml")!)
        
        let viral = Category(title: "Tech",
                             rssURL: URL(string: "https://www.24sata.hr/feeds/fun.xml")!)
        
        let categoriesList = [popular, latest, news, show, sport, lifestyle, tech, viral]
        return Observable.just(categoriesList)
    }
}
