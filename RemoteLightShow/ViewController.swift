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
        if let rgbaString = notification.userInfo!["message"] as? String {
            stuffLabel.text = rgbaString
            if let rgbaArray = rgbaString.componentsSeparatedByString(",") as? [String] {
                let cgfloatArray = rgbaArray.map {
                    CGFloat(($0 as NSString).doubleValue)
                }
                
                println(rgbaArray)
                
                
                
                
//                let red = CGFloat((rgbaArray[0]! as NSString).doubleValue)
//                let red = CGFloat(NSNumberFormatter().numberFromString(rgbaArray[0]!))
//                let green = CGFloat(NSNumberFormatter().numberFromString(rgbaArray[1]!))
//                let blue = CGFloat(NSNumberFormatter().numberFromString(rgbaArray[2]!))
//                let alpha = (rgbaArray[3] as NSString).floatValue
                
//                self.view.backgroundColor = UIColor(red: cgfloatArray[0], green: cgfloatArray[1], blue: cgfloatArray[2], alpha: cgfloatArray[3])
                self.view.backgroundColor = UIColor(red: cgfloatArray[0], green: cgfloatArray[1], blue: cgfloatArray[2], alpha: 1)
            }
        }

//        self.view.backgroundColor = UIColor.redColor()
    }
}

