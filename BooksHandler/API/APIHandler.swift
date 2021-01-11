//
//  APIHandler.swift
//  BooksHandler
//
//  Created by Anshu Vij on 1/7/21.
//

import Foundation

struct APIHandler {
    
    let baseUrl = "https://run.mocky.io/v3/8bcae4c3-d313-4f72-8e85-86ca7b87286a"
    
    var delegate : BooksDelegate?
    
    func fetchUserData()
    {
       
        performRequest(with: baseUrl)
    }
    
    func performRequest(with urlString : String){
        if let url  = URL(string: urlString)
        {
            let request = URLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data
                {
                    print("booksData : \(safeData)")
                    let userData = self.parseJSON(safeData)
                    self.delegate?.getBooksData(self, booksData: userData)
                    
                }
                
            }
            
            task.resume()
        }
        
    }
    
    func parseJSON( _ booksData : Data) -> [BooksData]
   {
       var booksDataValue:[BooksData]?
       let decoder = JSONDecoder()
           do {
               let decodeData : [BooksData] = try decoder.decode([BooksData].self, from: booksData)
            booksDataValue = decodeData
           }
      
       
        catch DecodingError.dataCorrupted(let context) {
            print(context)
        } catch DecodingError.keyNotFound(let key, let context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.valueNotFound(let value, let context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch DecodingError.typeMismatch(let type, let context) {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        catch {
        self.delegate?.didFailWithError(error: error)
       booksDataValue = []
           
       }

        return booksDataValue ?? []
   }
}
