import Cocoa
import XCGLogger
import Alamofire

class ViewController: NSViewController {
	private let logger = XCGLogger.default

	let array = ["在席", "離席", "外出", "休暇", "電話中", "打ち合わせ中", "退社"]

	@IBOutlet weak var popUpButton: NSPopUpButton!

	@IBOutlet weak var idTextField: NSTextField!

	@IBOutlet weak var nameTextField: NSTextField!

	@IBOutlet weak var messageTextField: NSTextField!

	@IBOutlet weak var sendCheck: NSButton!

	override func viewDidLoad() {
		super.viewDidLoad()
		popUpButton.addItems(withTitles: array)
		let ud = UserDefaults.standard
		idTextField.stringValue = ud.object(forKey: "id") != nil ? ud.string(forKey: "id")! : ""
		nameTextField.stringValue = ud.object(forKey: "name") != nil ? ud.string(forKey: "name")! : ""

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

	func screenIsLocked() {
		if (sendCheck.state == NSOnState) {
			self.popUpButton.selectItem(at: 1)
			postEvent()
		}
	}

	func screenIsUnlocked() {
		if (sendCheck.state == NSOnState) {
			self.popUpButton.selectItem(at: 0)
			postEvent()
		}
	}

	@IBAction func updateClick(_ sender: NSButtonCell) {
		postEvent()
	}

	func postEvent() {
		let id = idTextField.stringValue;
		let name = nameTextField.stringValue;

		if (id.isEmpty || name.isEmpty) {
			logger.error("未設定の項目があります")
			return;
		}

		let selected = popUpButton.indexOfSelectedItem;
		let message = messageTextField.stringValue;
		var parameters: Parameters = [
				"name": name,
				"status": array[selected]
		]

		if (!message.isEmpty) {
			parameters["message"] = message
		}

		Alamofire.request("https://iruca.co/api/rooms/12ebc2b1-695b-4291-ba21-c8c948308ad7/members/" + id, method: .put, parameters: parameters)
				.response { response in
					if (response.response?.statusCode != 200 || response.error != nil) {
						self.logger.error("エラー")
					} else {
						self.logger.error("成功!")
						self.messageTextField.stringValue = ""

						switch selected {
						case 0:
							self.popUpButton.selectItem(at: 1)
							break
						case 1:
							self.popUpButton.selectItem(at: 0)
							break
						default:
							break
						}

						let ud = UserDefaults.standard
						ud.set(id, forKey: "id")
						ud.set(name, forKey: "name")
					}
				}
	}

	override var representedObject: Any? {
		didSet {
			// Update the view, if already loaded.
		}
	}

}

