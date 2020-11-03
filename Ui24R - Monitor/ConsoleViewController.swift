//
//  ConsoleViewController.swift
//  Ui24R - Monitor
//
//  Created by Junior Fernandes on 09/10/20.
//

import UIKit
import WebKit
import CoreData

class ConsoleViewController: UIViewController {
    
    @IBOutlet var webView: WKWebView!
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var fetchedResultController: NSFetchedResultsController<Entity>!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadConsole()
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func loadConsole() {
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
        guard let lastIndex = fetchedResultController.fetchedObjects?.endIndex else { return }
        guard let urls = fetchedResultController.fetchedObjects?[lastIndex-1] else {return}
        let urlLabel = String(urls.url!)
        
        webView.load(URLRequest(url: URL(string: "https://www.\(urlLabel)")!))
        print(webView.load(URLRequest(url: URL(string: "https://www.\(urlLabel)")!))!)
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        
    }
    
    @IBAction func Close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}

extension ConsoleViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        

    }
}
