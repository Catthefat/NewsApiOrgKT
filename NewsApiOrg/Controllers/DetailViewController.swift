//
//  DetailViewController.swift
//  NewsApiOrg
//
//  Created by Arkadijs Makarenko on 20/11/2021.
//

import UIKit
import SDWebImage
import CoreData

class DetailViewController: UIViewController {

    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    
    var webUrlString = String()
    var titleString = String()
    var contentString = String()
    var newsImage = String()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleString
        contentTextView.text = contentString
        newsImageView.sd_setImage(with: URL(string: newsImage), placeholderImage: UIImage(named: "news.png"))
                                  
    #warning("AppDelegate")
    }
    
    #warning("saveData")
    //saveData(){
    // basicAlert(saved! , please go to saved tab bar to see
//}
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let newItem = Items(context: context!)
//        item.
        
        //savedItems.append(newItem)
        //saveData()
    }
    
    


    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationVC: WebViewController = segue.destination as! WebViewController
        
        destinationVC.urlString = webUrlString
        // Pass the selected object to the new view controller.
    }


}
