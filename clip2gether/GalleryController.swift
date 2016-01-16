import Foundation
import UIKit

class GalleryController: UIViewController {
    
    // activity indicator for webview
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // Webview refresh button
    @IBAction func webRefresh(sender: AnyObject) {
        
        webview.reload()
        
    }
    
    // Webview forward button
    @IBAction func webFwd(sender: AnyObject) {
        
        if webview.canGoForward {
            
            webview.goForward()
            
        }
    }
    
    // Webview back button
    @IBAction func webBack(sender: AnyObject) {
        
        if webview.canGoBack {
            
            webview.goBack()
            
        }
        
    }
    
    @IBOutlet var webview: UIWebView!
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // UIColor(red: 50.0/255.0, green: 122.0/255.0, blue: 191.0/255.0, alpha: 1.0)
        
        let url = NSURL(string: "http://www.clip2gether.com/mobile/app/v1/iOS/wrapper/galerie.php")
        let request = NSURLRequest(URL: url!)
        
        webview.loadRequest(request)
        
        
        
    }
    
    // show activity indicator while loading
    func webViewDidStartLoad(_ : UIWebView) {
        
        if #available(iOS 9.0, *) {
            self.webview.allowsLinkPreview = true
        } else {
            // Fallback on earlier versions
        }
        self.webview.userInteractionEnabled = true
        self.webview.hidden = true
        activityIndicator.startAnimating()
        
    }
    
    // stop activity indicator when loading finished
    func webViewDidFinishLoad(_ : UIWebView) {
        
        if #available(iOS 9.0, *) {
            webview.allowsLinkPreview = true
        } else {
            // Fallback on earlier versions
        }
        self.webview.hidden = false
        activityIndicator.stopAnimating()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}