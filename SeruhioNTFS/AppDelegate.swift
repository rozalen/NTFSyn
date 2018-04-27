//
//  AppDelegate.swift
//  SeruhioNTFS
//
//  Created by Sergio Rozalén Barberán on 26/4/18.
//  Copyright © 2018 Sergio Rozalén Barberán. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        showVolumes()

        if let button = statusItem.button {
            button.title = "SNTFS!"
            button.action = #selector(AppDelegate.togglePopover(_:))
        }
        
        let mainViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: "ViewController")) as! ViewController
        
        popover.contentViewController = mainViewController
        
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown,.leftMouseDown]) { [unowned self] event in
            if self.popover.isShown {
                self.closePopover(event)
            }
        }
        eventMonitor?.start()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
    }
    
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    func showPopover(_ sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
        eventMonitor?.start()
    }
    
    func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func showVolumes(){
        let sourcePath = URL(fileURLWithPath: "/Volumes", isDirectory: true)
        let fileManager = FileManager.default
        
        do {
            
            let files = try fileManager.contentsOfDirectory(atPath: sourcePath.path)
            
            print("\nMostrando el contenido de la carpeta: \(sourcePath.path)\n")
            
            for var content in files {
                
                print(content)
                
            } // for
            
        } catch let error as NSError {
            
            print("Ooops! Ha ocurrido un error: \(error)")
            
        }
    }

}

