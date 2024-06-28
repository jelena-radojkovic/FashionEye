//
//  WebPreiewViewController.swift
//  FashionEye
//
//  Created by Jelena Radojkovic on 22.8.22..
//

import Foundation
import UIKit
import WebKit

class WebPreiewViewController: UIViewController {
    let webView = WKWebView()
    var urlString: String? = nil
    
    override func viewDidLoad() {
        view.addSubview(webView)
        
        guard let urlString = urlString else { return }
        guard let url = URL(string: urlString) else { return }
        
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
