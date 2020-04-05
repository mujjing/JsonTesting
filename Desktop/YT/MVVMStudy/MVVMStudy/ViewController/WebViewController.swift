//
//  WebViewController.swift
//  MVVMStudy
//
//  Created by Jh's MacbookPro on 2020/04/06.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = "https://rgbcolorcode.com/color/" + urlString
        
        let request = URLRequest(url: URL(string: url)!)
        
        self.webView.load(request)
       self.webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            if webView.isLoading {
                indicator.startAnimating()
                indicator.isHidden = false
            }else {
                indicator.stopAnimating()
                indicator.isHidden = true
            }
        }
    }

}
