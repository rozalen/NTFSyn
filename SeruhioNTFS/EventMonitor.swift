//
//  EventMonitor.swift
//  SeruhioNTFS
//
//  Created by Sergio Rozalén Barberán on 27/4/18.
//  Copyright © 2018 Sergio Rozalén Barberán. All rights reserved.
//

import Cocoa

open class EventMonitor: NSObject {
    fileprivate var monitor: AnyObject?
    fileprivate let mask: NSEvent.EventTypeMask
    fileprivate let handler: (NSEvent?) -> ()
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> ()) {
        self.mask = mask
        self.handler = handler
    }
    
    deinit {
        stop()
    }
    
    open func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler) as AnyObject?
    }
    
    open func stop() {
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil
        }
    }
}
