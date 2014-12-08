//
//  InterfaceController.swift
//  BitWatch WatchKit Extension
//
//  Created by Niraj Pant on 12/7/14.
//  Copyright (c) 2014 Niraj Pant All rights reserved.
//

import WatchKit
import Foundation
import BitWatchKit


class InterfaceController: WKInterfaceController {
    
    let tracker = Tracker()
    var updating = false

    @IBOutlet weak var priceLabel: WKInterfaceLabel!
    
    override init(context: AnyObject?) {
        // Initialize variables here.
        super.init(context: context)
        updatePrice(tracker.cachedPrice())
        
        // Configure interface objects here.
        NSLog("%@ init", self)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        NSLog("%@ will activate", self)
        update()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }

    @IBAction func refreshTapped() {
        update()
    }
    
    private func updatePrice(price: NSNumber) {
        priceLabel.setText(Tracker.priceFormatter.stringFromNumber(price))
    }
    
    private func update() {
        if !updating {
            updating = true
            
            let originalPrice = tracker.cachedPrice()
            tracker.requestPrice { (price, error) -> () in
                if error == nil {
                    self.updatePrice(price!)
                }
                self.updating = false
            }
        }
    }
}
