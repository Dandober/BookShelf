//
//  BookManager.swift
//  Book Shelf
//
//  Created by Daniel Döbereiner on 21/10/22.
//

import Foundation

protocol BookManagerDelegate {
    func didUpdateBook(_ bookManager: BookManager, book: BookModel)
    func didFailWithError(error: Error)
}

struct BookManager {
    let bookURL = "https://api.mercadoeditorial.org/api/v1.2/book?"
    
    var delegate: BookManagerDelegate?
    
    func fetchIsbnBook(isbnNumber: String) {
        let urlString = "\(bookURL)isbn=\(isbnNumber)"
        performRequest(with: urlString)
    }
    func fetchNameBook(bookName: String) {
        let urlString = "\(bookURL)titulo=\(bookName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let book =  parseJSON(safeData) {
                        self.delegate?.didUpdateBook(self, book: book)
                    }
                }
            }
            
            task.resume()
        }
        func parseJSON(_ bookData: Data) -> BookModel? {
            let decoder = JSONDecoder()
            do {
               let decodedData = try decoder.decode(BookData.self, from: bookData)
                let bookTitle = decodedData.books[0].titulo
                let bookSummary = decodedData.books[0].sinopse
                
                
                let book = BookModel(BookTitle: bookTitle, BookSummary: bookSummary)
                return book
                
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
                
        }
    }
    
    
    
}

