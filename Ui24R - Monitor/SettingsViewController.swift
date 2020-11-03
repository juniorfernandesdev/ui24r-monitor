//
//  SettingsViewController.swift
//  Ui24R - Monitor
//
//  Created by Junior Fernandes on 09/10/20.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {
    @IBOutlet weak var lbURL: UITextField!
    @IBOutlet weak var btSave: UIButton!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var entity: Entity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btSave.layer.cornerRadius = 5
    }
    
    @IBAction func closeSetting(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveSetting(_ sender: UIButton) {
        if entity == nil {
            entity = Entity(context: context)
        }
        
        entity.url = lbURL.text
        
        do{
           try context.save()
            print("dado inserido")
        } catch {
            print(error.localizedDescription)
        }
        
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Setting", message: "IP address saved successfully", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { action in
            print("tapped Dismiss")
        }))
        
        present(alert, animated: true)
        
    }
    
}
