//
//  TBWebViewVC.swift
//  SwiftProjectExample
//
//  Created by bob on 2019/8/9.
//  Copyright © 2019 bob. All rights reserved.
//

import UIKit
import WebKit

class TBWebViewVC: UIViewController {

    var url : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        self.view.addSubview(webView)
        self.view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(TBNavigationHeight)
            make.height.equalTo(2)
        }
        
        webView.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(self.view)
        }
        let request :URLRequest = URLRequest.init(url: NSURL.init(string: url ?? "")! as URL)
        webView.load(request)
        
    }
    
    lazy var webView : WKWebView = {
        var configure :WKWebViewConfiguration = WKWebViewConfiguration()
        let web = WKWebView.init(frame: .zero, configuration: configure)
        web.navigationDelegate = self
        web.uiDelegate = self
        web.allowsBackForwardNavigationGestures = true
        web.addObserver(self, forKeyPath: NSStringFromSelector(#selector(getter: WKWebView.estimatedProgress)), options: [], context: nil)
        web.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        return web
    }()
    
   
    var progressView :UIProgressView = {
       var pro = UIProgressView.init(progressViewStyle: .default)
        pro.backgroundColor = .blue
        pro.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
        pro.progressTintColor = .red
        pro.trackTintColor = .white
        return pro
    }()
    
    
    
    init(urlString : String) {
        super.init(nibName: nil, bundle: nil)
        self.url = urlString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        webView.removeObserver(self, forKeyPath: "title")
    }
    
}


extension TBWebViewVC : WKNavigationDelegate {
    
     // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        self.progressView.isHidden = false
        
    }
    // 页面加载失败时调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.progressView.isHidden = true
        self.progressView.setProgress(0.0, animated: true)
        
    }
    
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    // 页面加载完成之后调用
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.progressView.isHidden = true
    }
    
     //提交发生错误时调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
         self.progressView.isHidden = true
         self.progressView.setProgress(0.0, animated: true)
    }
    
    /*
     // 根据WebView对于即将跳转的HTTP请求头信息和相关信息来决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if navigationAction.navigationType == .linkActivated{
            
            decisionHandler(.cancel)
        }else{
            decisionHandler(.allow)
        }
        
    }
    
    // 根据客户端受到的服务器响应头以及response相关信息来决定是否可以跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        decisionHandler(.allow)
    }
    
     //需要响应身份验证时调用 同样在block中需要传入用户身份凭证
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

    }
    */
    //进程被终止时调用
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
        
    }
    
}


extension TBWebViewVC :WKUIDelegate {
    
    /*  web界面中有弹出警告框时调用
    *
    *  @param webView           实现该代理的webview
    *  @param message           警告框中的内容
    *  @param completionHandler 警告框消失调用
    */
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        
        
    }
    
    // 确认框
    //JavaScript调用confirm方法后回调的方法 confirm是js中的确定框，需要在block中把用户选择的情况传递进去
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    // 输入框
    //JavaScript调用prompt方法后回调的方法 prompt是js中的输入框 需要在block中把用户输入的信息传入
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
    }
    
    // 页面是弹出窗口 _blank 处理
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if !navigationAction.targetFrame!.isMainFrame{
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
}



// MARK: - js调用app
extension TBWebViewVC :WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        
        
    }
    
}


extension TBWebViewVC {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" ,object is WKWebView {
            progressView.progress = Float(webView.estimatedProgress)
            
            if Float(webView.estimatedProgress) >= 1.0 {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.progressView.progress = 0
                    self.progressView.isHidden = true
                    
                }
                
            }
            
        }else if keyPath == "title" ,object is WKWebView {
            
            self.navigationItem.title = webView.title
            
        }else{
            
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            
        }
        
    }
}
