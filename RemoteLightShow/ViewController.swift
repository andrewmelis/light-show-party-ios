import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMessageFromServer:", name: "MessageFromServer", object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var stuffLabel: UILabel!
    
    func handleMessageFromServer(notification: NSNotification) {
        println(notification)
        if let partyDict = notification.userInfo as? [String : String] {
            let name = partyDict["name"]!
            stuffLabel.text = "\(name)'s party"
            
            println(partyDict)
            let rgbString = partyDict["rgb"]!
            setBackgroundFromPartyDictionary(rgbString)
        }
    }
    
    func setBackgroundFromPartyDictionary(rgbString: String) {
        let rbgaArray = rgbString.componentsSeparatedByString(",")
        let cgfloatArray = rbgaArray.map {
            CGFloat(($0 as NSString).doubleValue)
        }
        self.view.backgroundColor = UIColor(red: cgfloatArray[0], green: cgfloatArray[1], blue: cgfloatArray[2], alpha: 1)
    }
}