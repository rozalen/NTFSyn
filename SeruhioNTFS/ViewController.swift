//
//  ViewController.swift
//  SeruhioNTFS
//
//  Created by Sergio Rozalén Barberán on 26/4/18.
//  Copyright © 2018 Sergio Rozalén Barberán. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var devicesTable: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func closeButtonAction(_ sender: NSButton) {
        NSApp.terminate(self)
    }
    
    

}

