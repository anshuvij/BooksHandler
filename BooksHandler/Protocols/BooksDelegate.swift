//
//  BooksDelegate.swift
//  BooksHandler
//
//  Created by Anshu Vij on 1/7/21.
//

import Foundation
protocol BooksDelegate {
    func getBooksData(_ APIHandler : APIHandler, booksData : [BooksData])
    func didFailWithError(error : Error)
}
