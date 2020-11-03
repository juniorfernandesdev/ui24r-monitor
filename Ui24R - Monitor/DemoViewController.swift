//
//  DemoViewController.swift
//  Ui24r Monitor
//
//  Created by Junior Fernandes on 09/10/20.
//

import UIKit
import WebKit

class DemoViewController: UIViewController {
    
    @IBOutlet var webview: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.load(URLRequest(url: URL(string: "https://10.10.1.1/phone.html")!))
        
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    

    @IBAction func Close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
