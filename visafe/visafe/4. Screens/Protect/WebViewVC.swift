import UIKit
import WebKit

class WebViewVC: BaseViewController {
    @IBOutlet weak var webview: WKWebView!
    var url: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _url = url, let myURL = URL(string: _url) else {
            return
        }
        let myRequest = URLRequest(url: myURL)
        webview.load(myRequest)
        if (_url == "https://congcu.khonggianmang.vn/checklist-macos"
        || _url == "https://congcu.khonggianmang.vn/checklist-windows"
        || _url == "https://congcu.khonggianmang.vn/checklist-ios"
        || _url == "https://congcu.khonggianmang.vn/checklist-android")
        {
            self.title = "Cẩm nang an toàn thông tin"
        }
        else
        {
            self.title = "Tiện ích an toàn thông tin"
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
}
