//
//  UploadViewController.swift
//  clip2gether
//
//  Created by Ali on 20.08.15.
//  Copyright © 2015 Remanence. All rights reserved.
//

import UIKit
import Foundation

class UploadViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet var locImage: UIImageView!
    @IBOutlet var message: UITextField!
    @IBOutlet var sendButton: UIButton!
    
    @IBAction func sendButtonPressed(sender: AnyObject) {
        
        send()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event!)
    }
    
    // Automatic login after textfield
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        message.resignFirstResponder()
        if textField == message {
            send()
            
        }
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        dispatch_async(dispatch_get_main_queue(),{
            self.message.roundCorners([UIRectCorner.BottomLeft , UIRectCorner.BottomRight], radius: 3.0)
            self.sendButton.layer.cornerRadius = 3.0
        })
        
        locImage.image = globalImage

        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(activityIndicator)
        
    }
    
    
    // http://www.clip2gether.com/mobile/app/v1/iOS/upload/upload.php
    
    func send()
    {
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://www.clip2gether.com/mobile/app/v1/iOS/upload/upload.php")!)
        
        request.HTTPMethod = "POST"
        
        let imageData :NSData = UIImageJPEGRepresentation(globalImage, 1.0)!;
        
        let boundary = "SwiftBoundary"
        let contentType = "multipart/form-data; boundary=\(boundary)"
        let fileName = "\(globalImage.hash).jpg"
        let parameterName = "contest-photo"
        
        let body = NSMutableData()
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"username\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("\(globalUsr)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"photo-name\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("\(message.text!)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"photo-description\"\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("\(message.text)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Disposition: form-data; name=\"\(parameterName)\"; filename=\"\(fileName)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Content-Type: image/jpeg\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(imageData)
        body.appendData("\r\n--\(boundary)--".dataUsingEncoding(NSUTF8StringEncoding)!)
        
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        request.setValue("\(body.length)", forHTTPHeaderField: "Content-Length")
        request.HTTPBody = body
        
        request.HTTPBody = body
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            if let error = error { print(error) }
            if let data = data{ print("data =\(data)") }
            if let response = response {
                print("response = \(response)")
                
                dispatch_async(dispatch_get_main_queue()) {
                    activityIndicator.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    
                    
                    let alertController = UIAlertController(title: "Danke", message: "Vielen Dank für das Hochladen deines 2fies.", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
                        action in
                        dispatch_async(dispatch_get_main_queue()) {
                            self.locImage = nil
                            self.message = nil
                            self.performSegueWithIdentifier("afterUpload", sender: self)
                        }
                    }))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                    
                    self.performSegueWithIdentifier("afterUpload", sender: self)
                }
                
            }
        })
        task.resume()
    }
        
    
}

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

