import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, NSMenuDelegate {

    @IBOutlet weak var statusMenu:NSMenu!
    
    let LEFT_MOUSE_BUTTON = 1
    
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    let iconEyeOpen = NSImage(named: "EyeOpen")
    let iconEyeClosed = NSImage(named: "EyeClosed")
    
    var task = NSTask()
    var stayAwake = false
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        iconEyeOpen?.setTemplate(true)
        iconEyeClosed?.setTemplate(true)
        
        statusItem.image = iconEyeClosed
        
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
        } else {
            disableInsomnia()
        }
        
    }

    @IBAction func aboutMenuItemClicked(sender: AnyObject) {
        let url = NSURL(string: "https://github.com/kasoki/stay-awake#stay-awake")
        
        NSWorkspace.sharedWorkspace().openURL(url!)
    }

    @IBAction func quitMenuItemClicked(sender: AnyObject) {
        disableInsomnia()
        exit(0)
    }
    
    func enableInsomnia() {
        stayAwake = true
        
        statusItem.image = iconEyeOpen
        
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
        
        statusItem.image = iconEyeClosed
        
        if task.running {
            task.interrupt()
        }
    }

}

