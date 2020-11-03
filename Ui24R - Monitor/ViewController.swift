//
//  ViewController.swift
//  Ui24R - Monitor
//
//  Created by Junior Fernandes on 09/10/20.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var btConsole: UIButton!
    @IBOutlet weak var btDemo: UIButton!
    
    @IBOutlet weak var lbUrlHome: UILabel!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var fetchedResultController: NSFetchedResultsController<Entity>!

    override func viewDidLoad() {
        super.viewDidLoad()
        btDemo.layer.cornerRadius = 15
        btConsole.layer.cornerRadius = 15
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        loadSetting()
    }
    
    
    
    
    func loadSetting() {
        let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest()
        let sortDescritor = NSSortDescriptor(key: "url", ascending: true)
        fetchRequest.sortDescriptors = [sortDescritor]
        
//      efetuando a requisicao
        fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultController.delegate = self
        
        do{
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
        
        if fetchedResultController.fetchedObjects?.count == 0 {
            return print("Nenhum registro!")
        }else {
            guard var lastIndex = fetchedResultController.fetchedObjects?.endIndex else { return }
            guard var urls = fetchedResultController.fetchedObjects?[lastIndex-1] else {return}
            var urlLabel = String(urls.url!)
            
            lbUrlHome.text = urlLabel
            print("função loadSetting chamada")
            guard let count = fetchedResultController.fetchedObjects?.count else {return}
            print(count)
        }
        
        
    }


}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        

    }
}

