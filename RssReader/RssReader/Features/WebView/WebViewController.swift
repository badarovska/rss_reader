//
//  WebViewController.swift
//  RssReader
//
//  Created by WF | Gordana Badarovska on 28.8.21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    private let webView = WKWebView()
    private let errorLabel = UILabel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    private var isLoading = false {
        didSet {
            errorLabel.isHidden = true
            loadingIndicator.isHidden = !isLoading
            isLoading ? loadingIndicator.startAnimating()
                : loadingIndicator.stopAnimating()
        }
    }
        
    private let errorMessage
        = """
        Whoops!
        An error happened!
    """
    
    init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        load(url: url)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.white
        
        webView.navigationDelegate = self
        webView.backgroundColor = UIColor.white
        webView.contentMode = .scaleAspectFit
        view.addSubview(webView)
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        errorLabel.textColor = UIColor.black
        errorLabel.font = UIFont(name: "AvenirNext-Medium", size: 20)
        errorLabel.text = errorMessage
        view.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        view.addSubview(loadingIndicator)
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }
    
    private func load(url: URL) {
        isLoading = true
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        isLoading = false
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        isLoading = false
        errorLabel.isHidden = false
    }
}

