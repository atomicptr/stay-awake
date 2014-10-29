import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {

    @IBOutlet weak var statusMenu:NSMenu!
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        statusItem.title = "Stay Awake"
        
        statusMenu.delegate = self
        
        statusItem.menu = statusMenu
    }
    
    func applicationWillTerminate(aNotification: NSNotification) {
    }

    func menuWillOpen(menu:NSMenu) {
        let mouseButton = NSEvent.pressedMouseButtons()
        
        if mouseButton == 1 {
            // don't open menu
            menu.cancelTracking()
            
            menuItemClicked()
        }
    }
    
    func menuItemClicked() {
        println("Test")
    }

    @IBAction func aboutMenuItemClicked(sender: AnyObject) {
    }

    @IBAction func quitMenuItemClicked(sender: AnyObject) {
    }

}

