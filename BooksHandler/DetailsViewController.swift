//
//  DetailsViewController.swift
//  BooksHandler
//
//  Created by Anshu Vij on 1/7/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var type : String?
    var value : String?
    
    var books : [Books]?
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        books = DatabaseController.getSelectedSectionData(type: (type?.lowercased())!, value: value!)
    }
    


}

extension DetailsViewController : UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension DetailsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let book = books![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        cell.labelView.text = book.value(forKey: "book_title") as? String
        cell.imageViewImage.loadImagesUsingUrl(urlString: (book.value(forKey: "image_url") as? String)!)
        

        
       
        return cell
    }
    
    
}

extension UIImageView {
//    func downloadFrom(link:String?, contentMode mode: UIView.ContentMode) {
//        contentMode = mode
//        image = UIImage(named: "default")
//        if link != nil, let url = NSURL(string: link!) {
//            URLSession.shared.dataTask(with: url as URL) { data, response, error in
//                guard let data = data else {
//                    print("\nerror on download \(error)")
//                    return
//                }
//                if let httpResponse = response as? HTTPURLResponse , httpResponse.statusCode != 200 {
//                    print("statusCode != 200; \(httpResponse.statusCode)")
//                    return
//                }
//                DispatchQueue.main.async
//                    {
//                    print("\ndownload completed \(url.lastPathComponent!)")
//                    self.image = UIImage(data: data)
//                }
//                }.resume()
//        } else {
//            self.image = UIImage(named: "default")
//        }
//    }
    
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.image = UIImage(data: data)
             }
          }
       }).resume()
    }
}
