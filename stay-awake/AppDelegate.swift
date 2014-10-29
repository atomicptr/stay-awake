//
//  AppDelegate.swift
//  stay-awake
//
//  Created by Christopher Kaster on 29/10/14.
//  Copyright (c) 2014 Christopher Kaster. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var statusMenu:NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }

    @IBAction func aboutMenuItemClicked(sender: AnyObject) {
    }

    @IBAction func quitMenuItemClicked(sender: AnyObject) {
    }

}

