//
//  ViewController.swift
//  Book Shelf
//
//  Created by Daniel Döbereiner on 21/10/22.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, BookManagerDelegate {
    
    @IBOutlet weak var isbnTextField: UITextField!
    
    @IBOutlet weak var BookTitleLabel: UILabel!
    
    
    @IBOutlet weak var BookSummaryLabel: UITextView!
    
    
    var bookManager = BookManager()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        bookManager.delegate = self
        isbnTextField.delegate = self
       
        
    }

    @IBAction func isbSearchButton(_ sender: UIButton) {
        isbnTextField.endEditing(true)
       // bookTitleLabel.text = bookT
        print(isbnTextField.text!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isbnTextField.endEditing(true)
        print(isbnTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "insira um número"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let isbn = isbnTextField.text{
            bookManager.fetchIsbnBook(isbnNumber: isbn)
        }
        isbnTextField.text = ""
    }
    func didUpdateBook(_ bookManager: BookManager, book: BookModel) {
        DispatchQueue.main.async {
            self.BookTitleLabel.text = book.BookTitle
            self.BookSummaryLabel.text = book.BookSummary
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

