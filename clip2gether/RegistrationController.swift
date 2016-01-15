//
//  RegistrationController.swift
//  clip2gether
//
//  Created by Ali on 23.08.15.
//  Copyright © 2015 Remanence. All rights reserved.
//

import UIKit
import CoreData
import QuartzCore


class RegistrationController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Border username
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor.lightGrayColor().CGColor
        border.frame = CGRect(x: 0, y: username.frame.size.height - width, width:  username.frame.size.width, height: username.frame.size.height)
        
        border.borderWidth = width
        username.layer.addSublayer(border)
        username.layer.masksToBounds = true
        
        //Border email
        let border2 = CALayer()
        let width2 = CGFloat(0.5)
        border2.borderColor = UIColor.lightGrayColor().CGColor
        border2.frame = CGRect(x: 0, y: email.frame.size.height - width, width:  email.frame.size.width, height: email.frame.size.height)
        
        border2.borderWidth = width2
        email.layer.addSublayer(border2)
        email.layer.masksToBounds = true
        
        // Padding for textFields
        let paddingView = UIView(frame: CGRectMake(0, 0, 15, self.username.frame.height))
        username.leftView = paddingView
        username.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView2 = UIView(frame: CGRectMake(0, 0, 15, self.email.frame.height))
        email.leftView = paddingView2
        email.leftViewMode = UITextFieldViewMode.Always
        
        let paddingView3 = UIView(frame: CGRectMake(0, 0, 15, self.password.frame.height))
        password.leftView = paddingView3
        password.leftViewMode = UITextFieldViewMode.Always
        
        // Rounded corners
        dispatch_async(dispatch_get_main_queue(),{
            self.username.roundCorners([UIRectCorner.TopRight , UIRectCorner.TopLeft], radius: 3.0)
            self.password.roundCorners([UIRectCorner.BottomLeft , UIRectCorner.BottomRight], radius: 3.0)
            self.registerButton.layer.cornerRadius = 3.0
        })
        
        // Hide NavigationBar
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        // Activity Indicator while loading page
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event!)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == username { // focus on next textfield
            email.becomeFirstResponder()
        } else if textField == email {
            password.becomeFirstResponder()
        } else if textField == password { // login after last textfield
            signup()
        }
        return true
    }
    
    @IBAction func signupButtonPressed(sender: AnyObject) {
        
        signup()
        
    }
    
    
    func signup() {
        
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let usr = username.text!
        let pwd = password.text!
        let em = email.text!
        
        // Transfer user information to global variable for image upload
        globalUsr = usr
        globalPwd = pwd
        globalEmail = em
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.clip2gether.com/mobile/app/v1/iOS/register/register.php")!)
        request.HTTPMethod = "POST"
        let postString = "commkey=\(key)&username=\(usr)&password=\(pwd)&email=\(em)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
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
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            let intResponseString = responseString?.intValue
            //print("responseString = \(responseString!)", terminator: "")
            
            // Switch for different error messages
                switch intResponseString! {
                    
                case 200:
                    NSLog("Login hat funktioniert")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        self.performSegueWithIdentifier("signupLogin", sender: self)
                        activityIndicator.stopAnimating()
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                    }
                case 201:
                    NSLog("Fehler: Benutzername existiert bereits")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.hidden = true
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        let alertController = UIAlertController(title: "Fehler", message: "Dieser Benutzername existiert bereits.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ändern", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                case 202:
                    NSLog("Fehler: Email existiert bereits")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.hidden = true
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        let alertController = UIAlertController(title: "Fehler", message: "Diese Email-Adresse existiert bereits.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Ändern", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                case 203:
                    NSLog("Fehler: Keinen Benutzernamen angegeben")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.hidden = true
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        let alertController = UIAlertController(title: "Fehler", message: "Du brauchst einen Benutzernamen.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Eingeben", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                case 205:
                    NSLog("Fehler: Keine Email angegeben")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.hidden = true
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        let alertController = UIAlertController(title: "Fehler", message: "Du brauchst eine Email Adresse.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Eingeben", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                case 204:
                    NSLog("Fehler: Kein Passwort angegeben")
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.hidden = true
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        let alertController = UIAlertController(title: "Fehler", message: "Du brauchst ein Passwort.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Eingeben", style: UIAlertActionStyle.Default, handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    }
                default:
                    
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        activityIndicator.stopAnimating()
                        activityIndicator.hidden = true
                        UIApplication.sharedApplication().endIgnoringInteractionEvents()
                        
                        let alertController = UIAlertController(title: "Huch", message: "Es ist ein allgemeiner Fehler aufgetreten.", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "Nochmal versuchen", style: UIAlertActionStyle.Default, handler: nil))
                    }
                }
            
        }
        task.resume()
        
    }

}
