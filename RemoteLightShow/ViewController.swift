import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleMessageFromServer:", name: "MessageFromServer", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "sendServerDeviceToken:", name: "RegisteredForNotifications", object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @IBOutlet weak var stuffLabel: UILabel!
    
    func sendServerDeviceToken(notification: NSNotification) {
        println("handled notification")
        if let tokenDict = notification.userInfo as? [String : String] {
            let tokenString = tokenDict["token"]!
            let body = serializeTokenRequestBody(tokenString)
            var request = NSMutableURLRequest(URL: NSURL(string: "https://blooming-meadow-9569.herokuapp.com/partygoer")!)
            request.HTTPMethod = "POST"
            request.HTTPBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                println(response)
            })
            
            task.resume()
        }
    }
    
    func serializeTokenRequestBody(token: String) -> NSData? {
        let tokenDictionary = ["token": token]
        var error: NSError?
        let userInfoJson = NSJSONSerialization.dataWithJSONObject(tokenDictionary, options: nil, error: &error)
        //        println("serialized to \(userInfoJson)")
        return userInfoJson
    }

    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let partyGoer = textField.text
        
//        println("submitted name \(partyGoer)")
        
        joinTheParty(partyGoer)
        return true
    }
    
    func joinTheParty(partyGoer: String) {
        let body = serializePartyRequestBody(partyGoer)
        var request = NSMutableURLRequest(URL: NSURL(string: "https://blooming-meadow-9569.herokuapp.com/party")!)
        request.HTTPMethod = "POST"
        request.HTTPBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
//            println(response)
        })
        task.resume()
        
    }
    

    
    func serializePartyRequestBody(partyGoer: String) -> NSData? {
        let userInfoDictionary = ["name": partyGoer]
        var error: NSError?
        let userInfoJson = NSJSONSerialization.dataWithJSONObject(userInfoDictionary, options: nil, error: &error)
//        println("serialized to \(userInfoJson)")
        return userInfoJson
    }
    
    func handleMessageFromServer(notification: NSNotification) {
        if let partyDict = notification.userInfo as? [String : String] {
            let name = partyDict["name"]!
            stuffLabel.text = "\(name)'s party"
            
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