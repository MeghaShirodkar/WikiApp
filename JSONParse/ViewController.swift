//
//  ViewController.swift
//  JSONParse
//
//  Created by GAURAV on 20/08/18.
//  Copyright © 2018 Jahnavi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var loadSpinner: UIActivityIndicatorView!
    var valueForURL : String!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _ = valueForURL else { return }
        let urlValue = valueForURL.replacingOccurrences(of: " ", with: "_", options: .literal, range: nil)
        let url = URL(string: "https://en.wikipedia.org/wiki/\(urlValue)")
        webView.loadRequest(URLRequest(url: url!))
    }
    
    func webViewDidStartLoad(_ : UIWebView) {
        loadSpinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ : UIWebView) {
        loadSpinner.stopAnimating()
    }

}
