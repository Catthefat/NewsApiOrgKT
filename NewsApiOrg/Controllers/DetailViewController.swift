//
//  DetailViewController.swift
//  NewsApiOrg
//
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
    
    @IBOutlet weak var detailsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleString
        detailsLabel.text = contentString
        newsImageView.sd_setImage(with: URL(string: newsImage), placeholderImage: UIImage(named: "news.png"))
               
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
    }
    
    func saveData(){
        do{
            try context?.save()
        }catch{
            fatalError("error in saving in core data item")
        }
        loadData()

    }
    func loadData(){
           let request: NSFetchRequest<Items> = Items.fetchRequest()
           do{
               let result = try  context?.fetch(request)
               savedItems = result!
           }catch{
               fatalError("error in loading core data item")
           }
       }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        let newItem = Items(context: context!)
        newItem.url = webUrlString
        newItem.newsContent = contentString
        newItem.newsTitle = titleString
        print("newItem.newsTitle: ", savedItems)
        savedItems.append(newItem)
        saveData()
        loadData()
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
