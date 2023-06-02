//
//  HomeViewController.swift
//  WebBrowserApp
//
//  Created by Fidaa Alamm on 02/06/2023.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var openBrowserButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func openBrowserButtonAction(_ sender: Any) {
        navigateToWebView()
    }

    /// func to navigate to the web view controller with the needed config.
    func navigateToWebView() {
        let webViewController = WKWebViewController()

        webViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(webViewController, animated: true)
    }
}
