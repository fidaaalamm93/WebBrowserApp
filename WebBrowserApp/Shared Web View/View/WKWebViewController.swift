//
//  WKWebViewController.swift
//  WebBrowserApp
//
//  Created by Fidaa Alamm on 02/06/2023.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var webView: WKWebView!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var forwordButton: UIButton!

    var webViewURLObserver: NSKeyValueObservation?

    // MARK: - Variables

    var viewModel: WebViewModel = WebViewModel()

    // MARK: - override Func
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTheme()
        setupLocalizations()
        config()
        webViewURLObserver = webView.observe(\.url, options: .new) { webview, change in
            print("URL: \(String(describing: change.newValue))")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.checkBackForwordStatus()
            }
        }
    }

    // MARK: - Setup

    /// config function to handle all things needed when this view controller opens.
    func config() {
        loadWebView(url: viewModel.output.initURL)
    }

    func setupUI() {
        setupNavigationBarLeftView()
        setupWebView()
        checkBackForwordStatus()
    }

    /// func to setup the UI in both themes: Light and Dark.
    func setupTheme() {
    }

    /// func to setup all translation texts with multiple languages.
    func setupLocalizations() {
        title = "Tamatem Plus"
    }

    // MARK: - Setup NavigationBar

    func setupNavigationBarLeftView() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "close"), for: .normal)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 30)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        let backItem = UIBarButtonItem(customView: backButton)

        self.navigationItem.setLeftBarButtonItems([backItem], animated: true)
    }

    @objc func backAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Setup Button Actions
    @IBAction func backButtonAction(_ sender: Any) {
        goBack()
    }

    @IBAction func forwardButtonAction(_ sender: Any) {
        goForword()
    }

    @IBAction func refreshButtonAction(_ sender: Any) {
        refresh()
    }

    // MARK: - Setup WebView

    func setupWebView() {
        webView.navigationDelegate = self
        webView.uiDelegate = self
        //        activityIndicator.startAnimating()
        webView.allowsBackForwardNavigationGestures = true
    }

    /// func to open the webview with a specific URL.
    func loadWebView(url: String) {
        //        showLoader(isLoading: true)
        webView.frame = view.frame

        guard let url = URL(string: url) else {
            webView.isHidden = true
            return
        }
        let urlRequest = URLRequest(url: url)

        webView.load(urlRequest)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    /// func to control of activityIndicator inside the webview.
    func showLoader(isLoading: Bool)  {
        activityIndicator.isHidden = !isLoading
        if isLoading {
            activityIndicator.startAnimating()

        } else {
            activityIndicator.stopAnimating()

        }
    }

    /// func to navigates to the back item in the back-forward list.
    func goBack() {
        webView.goBack()
        webView.reload()
    }

    /// func to navigates to the forward item in the back-forward list.
    func goForword() {
        webView.goForward()
        webView.reload()
    }

    /// func to reload the current item in the back-forward list, and if the url is empty the init url will open.
    func refresh() {
        if webView.url != nil {
            webView.reload()
        } else {
            loadWebView(url: viewModel.output.initURL)
        }
    }

    /// func to check the back and forword button status from back-forward list.
    func checkBackForwordStatus() {
        backButton.isEnabled = webView.canGoBack
        backButton.tintColor = webView.canGoBack ? .black : .gray

        forwordButton.isEnabled = webView.canGoForward
        forwordButton.tintColor = webView.canGoForward ? .black : .gray
    }

}

extension WKWebViewController {
    // MARK: - Setup WebView Delegate
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
            decisionHandler(.allow)
        }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        checkBackForwordStatus()
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil || navigationAction.targetFrame?.isMainFrame == false {
            if let url = navigationAction.request.url {
                UIApplication.shared.open(url)
            }
        }
        return nil
    }
}

