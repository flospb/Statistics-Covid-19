//
//  WebViewController.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 07.09.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Dependencies

    private var webView: WKWebView
    private var url: String

    // MARK: - Initialization

    init(url: String) {
        self.webView = WKWebView()
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: url) else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        self.navigationController?.isNavigationBarHidden = false
    }
}
