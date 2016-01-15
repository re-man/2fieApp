//
//  AppDelegate.swift
//  clip2gether
//
//  Created by Ali on 30.07.15.
//  Copyright (c) 2015 Remanence. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore

// Global user for identification when uploading 2fie
var globalUsr = ""
var globalPwd = ""
var globalEmail = ""
let key:String = "ASdno124KA123ASD230ASDm0"
var loggedIn = false;

// Declaration of loading wheel globally
var activityIndicator = UIActivityIndicatorView()

// Extension for textfields to get round corners
extension UITextField {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.masksToBounds = true
        self.layer.mask = mask
    }
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var passwordBottomConstraint: NSLayoutConstraint!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        
        login()
        
    }
    
    // Change to registration screen
    @IBAction func registrationButtonPressed(sender: AnyObject) {
        
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("registration", sender: self)
        }
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event!)
    }
    
    // Automatic jump to next textfield on return key and login after password
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == username {
            password.becomeFirstResponder()
        } else if textField == password {
            login()
            
        }
        return true
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        // Textfield bottom border
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: username.frame.size.height - width, width:  username.frame.size.width, height: username.frame.size.height)
        
        border.borderWidth = width
        username.layer.addSublayer(border)
        username.layer.masksToBounds = true
        
        // Left padding for textfields
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.username.frame.height))
        username.leftView = paddingView
        username.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 15, self.password.frame.height))
        password.leftView = paddingView2
        password.leftViewMode = UITextFieldViewMode.Always
        
        // Round corners for textfields and button
        dispatch_async(dispatch_get_main_queue(),{
            self.username.roundCorners([UIRectCorner.TopRight , UIRectCorner.TopLeft], radius: 3.0)
            self.password.roundCorners([UIRectCorner.BottomLeft , UIRectCorner.BottomRight], radius: 3.0)
            self.loginButton.layer.cornerRadius = 3.0
        })
        
        // Hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Initializing settings for activity indicator
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        
    }
    
    func login() {
        
        // Stop user actions
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        // send login data to global variable for 2fie upload later
        globalUsr = username.text!
        globalPwd = password.text!
        
        // Save CoreData
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedContext:NSManagedObjectContext = appDel.managedObjectContext!
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: managedContext)
        newUser.setValue(username.text, forKey: "username")
        newUser.setValue(password.text, forKey: "password")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        // Fetch CoreData
        var users = [NSManagedObject]()
        let fetchRequest = NSFetchRequest(entityName: "Users")
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            users = results as! [NSManagedObject]
            //print(users)
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        // PHP Post request to check credentials
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.clip2gether.com/mobile/app/v1/iOS/login/login.php")!)
        request.HTTPMethod = "POST"
        let postString = "commkey=\(key)&username=\(globalUsr)&password=\(globalPwd)" // check key, username and password
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            // Error message if no internet connection
            if error != nil {
                print("error=\(error)", terminator: "")
                
                dispatch_async(dispatch_get_main_queue()) {
                
                    activityIndicator.stopAnimating()
                    activityIndicator.hidden = true
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    let alertController2 = UIAlertController(title: "Fehler", message: "Du brauchst eine Internetverbindung.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController2.addAction(UIAlertAction(title: "Nochmal versuchen", style: UIAlertActionStyle.Cancel, handler: nil))
                    
                    
                    self.presentViewController(alertController2, animated: true, completion: nil)
                    
                }
                return
            }
            
            // Check responseString to authorize user
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let intResponseString = responseString?.intValue
            
            // Response 100 means user is authorized
            if intResponseString! == 100 {
                
                NSLog("Login hat funktioniert")
                loggedIn = true
                
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("login", sender: self)
                    activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                }
                
                
                
            }
            
            // Response 101 = user is not authorized
            if intResponseString! == 101 {
                
                NSLog("Login hat nicht funktioniert")
                loggedIn = false
                
                dispatch_async(dispatch_get_main_queue()) {
                    activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    let alertController = UIAlertController(title: "Fehler", message: "Du brauchst einen gültigen Account.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Account erstellen", style: UIAlertActionStyle.Default, handler: {
                        action in
                        dispatch_async(dispatch_get_main_queue()) {
                            self.performSegueWithIdentifier("registration", sender: self)
                        }
                    }))
                    alertController.addAction(UIAlertAction(title: "Nochmal versuchen", style: UIAlertActionStyle.Default, handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
                
            }
            
        }
        task.resume()
        
    }


}
