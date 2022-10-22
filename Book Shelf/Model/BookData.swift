//
//  BookData.swift
//  Book Shelf
//
//  Created by Daniel Döbereiner on 21/10/22.
//

import Foundation

struct BookData: Codable {
   
    let books: [Books]
    
}

struct Books: Codable {
    let titulo: String
    let sinopse: String
   
}




//books[0].titulo
