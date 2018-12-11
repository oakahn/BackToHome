import UIKit

protocol BaseVCProtocol: class {
    func displayMessage(title: String, message: String)
    func displayMessageWithCallBackOK(title: String, message: String, callback: @escaping () -> Void)
    func displayBlockMessage(title: String, message: String)
    func hideLoading()
    func displayMessageAndHide(title: String, message: String)
    func displayLoading(message: String, hasBg: Bool)
}

class BaseVC: UIViewController, BaseVCProtocol {
    var loadingView: LoadingXibView?
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onkeyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onkeyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil)
    }
    
    @objc func onkeyboardWillShow(_ notification: Notification) {}
    
    @objc func onkeyboardWillHide(_ notification: Notification) {}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    var isHideTitle: Bool {
        get {
            return self.isHideTitle
        }
        set {
            if self.navigationController == nil {
                return
            }
            self.navigationController?.setNavigationBarHidden(newValue, animated: false)
        }
    }
    
    func setNavigationTitle(title: String) {
        if self.navigationController == nil {
            return
        }
        self.navigationItem.title = title
    }
    
    func setTitleColor(font: UIFont = UIFont.kanitH8RegularStyle, color: UIColor) {
        if self.navigationController == nil {
            return
        }
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        //        self.navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font]
    }
    
    func displayMessage(title: String, message: String) {
        self.hideLoading()
        Alerts.withMessage(viewController: self, title: title, msg: message)
    }
    
    func displayMessageWithCallBackOK(title: String, message: String, callback: @escaping () -> Void) {
        self.hideLoading()
        Alerts.alertWithCallback(title: title, msg: message) { callback() }
    }
    
    func displayBlockMessage(title: String, message: String) {
        self.hideLoading()
        Alerts.blockMessage(title: title, msg: message)
    }
    
    func displayMessageWithCallbackOKAndCancel(title: String, message: String,
                                               okCallBack: @escaping () -> Void,
                                               cancelCallBack: @escaping () -> Void) {
        Alerts.alertWithOKCallback(title: title, msg: message, onOKSelected: {
            okCallBack()
        }, onCancelSelected: {
            cancelCallBack()
        })
    }
    
    func displayMessageWithCallbackOKAndCancel(title: String, message: String,
                                               okStringButton: String ,
                                               cancelStringButton: String ,
                                               okCallBack: @escaping () -> Void,
                                               cancelCallBack: @escaping () -> Void) {
        
        Alerts.alertWithOKCallback(title: title, msg: message, okStringButton: okStringButton, cancelStringButton: cancelStringButton, onOKSelected: {
            okCallBack()
        }) {
            cancelCallBack()
        }
    }
    
    func displayMessageWithCallbackOKAndCancel(title: String, message: String,
                                               okStringButton: String ,
                                               okTextColor: UIColor,
                                               cancelStringButton: String ,
                                               cancelTextColor: UIColor,
                                               okCallBack: @escaping () -> Void,
                                               cancelCallBack: @escaping () -> Void) {
        
        Alerts.alertWithOKCallback(title: title, msg: message, okStringButton: okStringButton,okTextColor: okTextColor, cancelTextColor: cancelTextColor, cancelStringButton: cancelStringButton, onOKSelected: {
            okCallBack()
        }) {
            cancelCallBack()
        }
    }
    
    func displayLoading(message: String, hasBg: Bool = false) {
        if loadingView == nil {
            loadingView = LoadingXibView(parentView: self.view, frame: self.view.frame)
        }
        self.loadingView?.show(message: message, hasBg: hasBg)
    }
    
    func hideLoading() {
        self.loadingView?.hide()
    }
    
    func overrideBackButton(){
        let backImage = UIImage.init(named: "icBack")?.withRenderingMode(.alwaysOriginal)
        let overrideBackButton = UIBarButtonItem.init(image: backImage, style: .plain, target: self, action: #selector(onBackPressed))
        self.navigationItem.leftBarButtonItem = overrideBackButton
        
    }
    
    @objc func onBackPressed() {
        dismiss()
    }
    
    func displayMessageAndHide(title: String, message: String) {
        self.hideLoading()
        Alerts.alertAndHide(title: title, msg: message)
    }
}

