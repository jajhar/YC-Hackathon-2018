//
//  UIViewController+Extensions.swift
//  Hackathon
//
//  Created by James Ajhar on 6/21/18.
//  Copyright © 2018 James Ajhar. All rights reserved.
//

import UIKit
import MobileCoreServices

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    var isVisible: Bool {
        return isViewLoaded && view.window != nil
    }
    
    func presentGenericErrorAlert(message: String? = "Something went wrong! Please try again.") {
        let alert = UIAlertController(title: "Uh Oh", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func presentGenericAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func instantiateViewController(withIdentifier identifier: String, inStoryboard storyboard: String) -> UIViewController? {
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func hideKeyboardWhenBackgroundTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(sender:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        let loc = sender.location(in: view)
        let subview = view.hitTest(loc, with: nil)
        // Views tagged with 9999 won't cause the keyboard to dismiss
        guard subview?.tag != 9999 else { return }
        view.endEditing(true)
    }
    
    func displayShareSheet(withText text: String) {
        let textShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
    
    func presentImagePicker(imagePicker: UIImagePickerController, sourceType: UIImagePickerController.SourceType, mediaTypes: [String] = [kUTTypeImage as String]) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else {
            presentGenericAlert(title: "Access Denied", message: "You must allow the app to access your camera or photo library in order to upload a photo or video. Please go to Settings->Privacy->Photos and allow Hackathon to access your camera or photo library.")
            return
        }
        
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = mediaTypes
        present(imagePicker, animated: true, completion: nil)
    }
    
    func dismissSelf(animated: Bool = true) {
        if navigationController != nil {
            if navigationController?.viewControllers.count == 1 {
                // Nothing left to pop, dismiss the nav controller
                navigationController?.dismissSelf()
            } else {
                navigationController?.popViewController(animated: animated)
            }
        } else {
            dismiss(animated: animated, completion: nil)
        }
    }
}

extension UIView {
    
    func displaySpinner() -> UIView {        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.translatesAutoresizingMaskIntoConstraints = false
        ai.color = .darkGray
        ai.startAnimating()
        
        performOnMainThread {
            self.addSubview(ai)
            ai.constrainToCenter()
            self.layoutIfNeeded()
        }
        
        return ai
    }
    
    func removeSpinner(spinner: UIView) {
        performOnMainThread {
            spinner.removeFromSuperview()
            self.layoutIfNeeded()
        }
    }
}

extension UIScrollView {
    
    func hideKeyboardWhenBackgroundTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(sender:)))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        self.endEditing(true)
    }
}

extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
