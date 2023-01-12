
import UIKit
import WebKit
import WowonderMessengerSDK

class WebViewVC: BaseVC {
    
    @IBOutlet weak var webView: WKWebView!
    
    var url:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.webView.navigationDelegate = self
        loadRequest(url: url ?? "")
    }
    
    private func loadRequest(url:String){
        let urlRequest = url
        let urlLoad = URL(string: urlRequest)
        let request = URLRequest(url: urlLoad ?? URL(string: "")!)
        webView.load(request)
    }
}
extension WebViewVC:WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.dismissProgressDialog {
            log.verbose("dismissed")
        }
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //
    }
}
