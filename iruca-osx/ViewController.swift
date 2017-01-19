import Cocoa

class ViewController: NSViewController {
	
	@IBOutlet weak var popUpButton: NSPopUpButton!
	
	@IBOutlet weak var idTextField: NSTextField!
	
	@IBOutlet weak var nameTextField: NSTextField!
	
	@IBOutlet weak var messageTextField: NSTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}

	override var representedObject: Any? {
		didSet {
			// Update the view, if already loaded.
		}
	}

}

