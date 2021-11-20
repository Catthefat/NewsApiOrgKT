//
//  Alert.swift
//  NewsApiOrg
//
//  Created by Arkadijs Makarenko on 19/11/2021.
//

import UIKit
import CoreData

var savedItems = [Items]()
var context: NSManagedObjectContext?

extension UIViewController {
    func basicAlert(title: String?, message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
//    func basicAlert2(indexPath: IndexPath) {
//            let alert = UIAlertController(title: "Delete?", message: "", preferredStyle: .alert)
//          let yes = UIAlertAction(title: "OK", style: .default) {
//                _ in context?.delete(savedItems[indexPath.row])
//            }
//            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alert.addAction(cancelButton)
//        alert.addAction(yes)
//            self.present(alert, animated: true, completion: nil)
//        }

    
}

