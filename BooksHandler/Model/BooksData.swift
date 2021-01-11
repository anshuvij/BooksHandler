//
//  BooksData.swift
//  BooksHandler
//
//  Created by Anshu Vij on 1/7/21.
//

import Foundation


struct BooksData : Codable {
    let id : String
    let book_title : String
    let author_name : String
    let genre : String
    let publisher : String
    let author_country : String
    let sold_count : Int
    let image_url : String
    
    
}
