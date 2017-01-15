import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

	func applicationDidFinishLaunching(_ aNotification: Notification) {
		// Insert code here to initialize your application

		DistributedNotificationCenter.default().addObserver(
						self,
						selector: #selector(self.screenIsLocked),
						name: NSNotification.Name(rawValue: "com.apple.screenIsLocked"),
						object: nil)

		DistributedNotificationCenter.default().addObserver(
						self,
						selector: #selector(self.screenIsUnlocked),
						name: NSNotification.Name(rawValue: "com.apple.screenIsUnlocked"),
						object: nil)
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		// Insert code here to tear down your application
	}

	func screenIsLocked() {
		print("screenIsLocked")
	}

	func screenIsUnlocked() {
		print("screenIsUnlocked")
	}

}
