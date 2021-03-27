//
//  StargazersDetailPopOver.swift
//  Stargazers
//
//  Created by Giuseppe Diciolla on 27/03/21.
//

import UIKit
import WebKit

class StargazersDetailPopOver: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var detailURLString = ""
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: detailURLString)!
        webView.load(URLRequest(url:url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    public func setUrl(url: String){
        self.detailURLString = url
    }
}
