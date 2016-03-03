//
//  ViewController.swift
//  clip2gether
//
//  Created by Ali on 30.07.15.
//  Copyright (c) 2015 Remanence. All rights reserved.
//

import UIKit
import AVFoundation
import Social
import SafariServices
import CoreData

var globalImage: UIImage = UIImage()

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var logoutBtn: UIButton!
    
    @IBAction func logoutButton(sender: AnyObject) {
        // Delete Userdata from Core
        let appDel:AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        let managedContext:NSManagedObjectContext = appDel.managedObjectContext!
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Users", inManagedObjectContext: managedContext)
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            let user = result[0] as! NSManagedObject
            managedContext.deleteObject(user)
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        do {
            try managedContext.save()
            NSLog("Logout war erfolgreich")
        } catch {
            let saveError = error as NSError
            print(saveError)
        }
        
        // Switch ViewController
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    @IBAction func cameraButton(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Quelle wählen", message: nil, preferredStyle: .ActionSheet)
        
        let kameraAction = UIAlertAction(title: "Kamera", style: .Default, handler: {
            action in
            self.openCamera()
            }
        )
        
        let galerieAction = UIAlertAction(title: "Galerie", style: .Default, handler: {
            action in
            self.openGallery()
            }
        )
        
        let defaultAction = UIAlertAction(title: "Abbrechen", style: .Cancel, handler: nil)
        
        alertController.addAction(kameraAction) // Adds Kamera button to Alert
        alertController.addAction(galerieAction) // Adds Galerie button to Alert
        alertController.addAction(defaultAction) // Adds Abbrechen button to Alert
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        let image = UIImagePickerController()
        
        image.delegate = self
        image.sourceType = .Camera
        image.allowsEditing = false
        image.cameraDevice = .Front // Selects front camera for less steps to take a 2fie
        
        self.presentViewController(image, animated: true, completion: nil)
    }
    func openGallery()
    {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = .PhotoLibrary
        image.allowsEditing = false
        
        self.presentViewController(image, animated: true, completion: nil)
    }

    // Jumps to upload scene after choosing or taking a picture
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        globalImage = image // sets global image to choosen image for upload scene to access
        self.dismissViewControllerAnimated(true, completion: nil)
        performSegueWithIdentifier("uploadedImage", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        dispatch_async(dispatch_get_main_queue(),{
            self.logoutBtn.layer.cornerRadius = 3.0
        })
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().statusBarStyle = .Default
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }


}

