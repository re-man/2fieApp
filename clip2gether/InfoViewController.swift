import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet var webView: UIWebView!
    @IBOutlet var textBox: UITextView!

    override func viewDidLoad() {
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Shows information page in webview
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        let myURL = NSURL(string: "http://www.clip2gether.com/mobile/app/v1/iOS/info.html");
        let myURLRequest:NSURLRequest = NSURLRequest(URL: myURL!);
        webView.loadRequest(myURLRequest);
    }

}
