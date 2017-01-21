import Cocoa
import XCGLogger

class ViewController: NSViewController {
	private let logger = XCGLogger.default
	
	let array = ["在席", "離席", "外出", "休暇", "電話中", "打ち合わせ中", "退社"]
	
	@IBOutlet weak var popUpButton: NSPopUpButton!
	
	@IBOutlet weak var idTextField: NSTextField!
	
	@IBOutlet weak var nameTextField: NSTextField!
	
	@IBOutlet weak var messageTextField: NSTextField!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		popUpButton.addItems(withTitles: array)
	}

	override var representedObject: Any? {
		didSet {
			// Update the view, if already loaded.
		}
	}

}

