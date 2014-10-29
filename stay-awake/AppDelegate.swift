import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {

    @IBOutlet weak var statusMenu:NSMenu!
    
    let LEFT_MOUSE_BUTTON = 1
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    var task = NSTask()
    var stayAwake = false
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem.title = "Stay Awake"
        
        statusMenu.delegate = self
        
        statusItem.menu = statusMenu
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
        disableInsomnia()
    }

    func menuWillOpen(menu:NSMenu) {
        let mouseButton = NSEvent.pressedMouseButtons()
        
        if mouseButton == LEFT_MOUSE_BUTTON {
            // don't open menu
            menu.cancelTracking()
            
            menuItemClicked()
        }
    }
    
    func menuItemClicked() {
        if(!stayAwake) {
            enableInsomnia()
            statusItem.title = "Awake"
        } else {
            disableInsomnia()
            statusItem.title = "Sleepy"
        }
        
    }

    @IBAction func aboutMenuItemClicked(sender: AnyObject) {}

    @IBAction func quitMenuItemClicked(sender: AnyObject) {
        disableInsomnia()
        exit(0)
    }
    
    func enableInsomnia() {
        stayAwake = true
        
        task = NSTask()
        
        task.launchPath = "/usr/bin/caffeinate"
        // -d prevent display sleep
        // -i prevent system idle sleep
        // -m prevent disk idle sleep
        task.arguments = ["-d", "-i", "-m"]
        
        task.launch()
    }
    
    func disableInsomnia() {
        stayAwake = false
        
        task.interrupt()
    }

}

