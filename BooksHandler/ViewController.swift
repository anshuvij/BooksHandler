//
//  ViewController.swift
//  BooksHandler
//
//  Created by Anshu Vij on 1/7/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var booksDataApi = APIHandler()
    var booksData : [BooksData]?
    
    var genereData : [String]?
    var authorData : [String]?
    var author_countryData: [String]?
    
    var sections = ["Genre","Authors","Country"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        booksDataApi.delegate = self
        
        booksDataApi.fetchUserData()
         
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
      
        addValuesToCoreData()
        
        
    }
    
    func addValuesToCoreData() {
        
        genereData = DatabaseController.getDifferentCategories(type: "genre")
        authorData = DatabaseController.getDifferentCategories(type: "author_name")
        author_countryData = DatabaseController.getDifferentCategories(type: "author_country")
        
        DatabaseController.saveContext()
    }
    
    
    func addBooksToCoreData(_ books: [BooksData]) {

           for book in books {
               let entity = NSEntityDescription.entity(forEntityName: "Books", in: DatabaseController.getContext())
               let newBook = NSManagedObject(entity: entity!, insertInto: DatabaseController.getContext())

               // Create a unique ID for the Book.
               let uuid = UUID()
               // Set the data to the entity
            newBook.setValue(book.author_country, forKey: "author_country")
            newBook.setValue(book.author_name, forKey: "author_name")
            newBook.setValue(book.book_title, forKey: "book_title")
            newBook.setValue(book.genre, forKey: "genre")
            newBook.setValue(book.id, forKey: "id")
            newBook.setValue(book.image_url, forKey: "image_url")
            newBook.setValue(book.publisher, forKey: "publisher")
            newBook.setValue(book.sold_count, forKey: "sold_count")
            newBook.setValue(uuid.uuidString, forKey: "uuid")
           }

       }
    


}

extension ViewController : BooksDelegate {
    func getBooksData(_ APIHandler: APIHandler, booksData: [BooksData]) {
        self.addBooksToCoreData(booksData)
                
        DatabaseController.deleteAllBooks()
       
         addValuesToCoreData()
        
        
        
        
    }
    
    func didFailWithError(error: Error) {
        
    }
    
    
}

extension ViewController : UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
           return genereData!.count
        }
        else if section == 1{
            return authorData!.count
        }
        else {
            return author_countryData!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        
        
        switch indexPath.section {
        case 0:
            cell?.textLabel?.text = genereData![indexPath.row].upperCamelCased
        case 1:
            cell?.textLabel?.text = authorData![indexPath.row].upperCamelCased
            
        default:
            cell?.textLabel?.text = author_countryData![indexPath.row].upperCamelCased
            
        }
       
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        
        vc.type = sections[indexPath.section]
        switch indexPath.section {
        case 0:
            vc.value = genereData![indexPath.row]
        case 1:
            vc.value = authorData![indexPath.row]
            
        default:
            vc.value = author_countryData![indexPath.row]
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }

    var upperCamelCased: String {
        return self.lowercased()
            .split(separator: " ")
            .map { return $0.lowercased().capitalizingFirstLetter() }
            .joined()
    }
    
    var lowerCamelCased: String {
        let upperCased = self.upperCamelCased
        return upperCased.prefix(1).lowercased() + upperCased.dropFirst()
    }
}

