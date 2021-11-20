//
//  SavedTableViewController.swift
//  NewsApiOrg
//
//

import UIKit
import CoreData
import SDWebImage

class SavedTableViewController: UITableViewController {
    
    @IBAction func HandleRefresh(_ sender: UIRefreshControl) {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { (timer) in
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        })

        
    }
    @IBOutlet var TbllView: UITableView!
    var savedItems = [Items]()
    var context: NSManagedObjectContext?
    var urlStr = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.reloadInputViews()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        loadData()
        
    }
    
    @IBAction func RefreshButton(_ sender: Any) {
        self.tableView.reloadData()
        self.loadData()
    }
    
    
    func loadData(){
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        do{
            let result = try  context?.fetch(request)
            savedItems = result!
            tableView.reloadData()
        }catch{
            fatalError("error in loading core data item")
        }
    }
    
    func saveData(){
        do{
            try context?.save()
        }catch{
            fatalError("error in saving in core data item")
        }
        loadData()
        
    }
    func basicAlert2(indexPath: IndexPath) {
        let alert = UIAlertController(title: "Delete?", message: "", preferredStyle: .alert)
        let yes = UIAlertAction(title: "OK", style: .default) { [self]
            _ in self.context?.delete(savedItems[indexPath.row])
            self.saveData()
            self.tableView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(yes)
        self.present(alert, animated: true, completion: nil)
       
        
    }
    
    func deleteAllData(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Items")
        let delete: NSBatchDeleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do{
            try context?.execute(delete)
            saveData()
        }catch let err {
            print(err.localizedDescription)
        }
    }
    
   
    
    @IBAction func DeleteButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete All Shopping items?", message: "Do you want to delete them all?", preferredStyle: .actionSheet)
        let addActionButton = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteAllData()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addActionButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
        saveData()
    }
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedItems.count
    }
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as? SavedTableViewCell else {return UITableViewCell()}
        
        let item = savedItems[indexPath.row]
        cell.SavedLabelText?.text = item.newsTitle
        //        cell.SavedLabelText.text = item.newsTitle
        // Configure the cell...
        cell.SavedContentLabel?.text = item.newsContent
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
//#warning("confirmation of detele Item")
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            basicAlert2(indexPath: indexPath)
            
        }
        saveData()
    }
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let destinationVC: WebViewController = segue.destination as! WebViewController
//        destinationVC.urlString = URL(string: url)
        // Pass the selected object to the new view controller.
    }

    
}
