//
//  ViewController.swift
//  SeruhioNTFS
//
//  Created by Sergio Rozalén Barberán on 26/4/18.
//  Copyright © 2018 Sergio Rozalén Barberán. All rights reserved.
//

import Cocoa
import Foundation
class ViewController: NSViewController , NSTableViewDataSource,NSTableViewDelegate{

    @IBAction func syncButton(_ sender: NSButton) {
       print("Boton presionado")
    }
    
    @IBOutlet weak var devicesTable: NSTableView!
    var data = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addVolumes()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    @IBAction func closeButtonAction(_ sender: NSButton) {
        NSApp.terminate(self)
    }
   
    func numberOfRows(in tableView: NSTableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
            return data[row]
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let cell = devicesTable.selectedRow
        print(cell)
        if(cell != -1){
            print(data[cell])
        }else{
            print("Celda sin valor seleccionada")
        }
        
    }
    
    func addVolumes(){
        let sourcePath = URL(fileURLWithPath: "/Volumes", isDirectory: true)
        let fileManager = FileManager.default
        
        do {
            
            let files = try fileManager.contentsOfDirectory(atPath: sourcePath.path)
            
            print("\nMostrando el contenido de la carpeta: \(sourcePath.path)\n")
            
            for var content in files {
                
                data.append(content)
                
            } // for
            
        } catch let error as NSError {
            
            print("Ooops! Ha ocurrido un error: \(error)")
            
        }
    }
}
