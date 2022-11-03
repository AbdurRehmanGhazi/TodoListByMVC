//
//  File.swift
//  Todo List
//
//  Created by Eapple on 03/11/2022.
//

import UIKit

extension UIViewController {
    
    func showToast(message : String) {

        let textview = UITextView(frame: CGRect(x: 0, y: 0, width: 250, height: 100))
        textview.backgroundColor = .green
        textview.font = UIFont.systemFont(ofSize: 14)
        textview.text = message
        
        let toastLabel = PaddingLabel(frame: CGRect(x: self.view.frame.size.width/2 - 125, y: self.view.frame.size.height-textview.contentSize.height-100, width: 250, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1.0)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.frame.size = textview.contentSize
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = Int(textview.contentSize.height / textview.font!.lineHeight)
        toastLabel.numberOfLines > 1 ? toastLabel.textAlignment = .justified : nil
        UIApplication.topViewController()?.view.addSubview(toastLabel)
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.9
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
        
    }
    
    func hideKeyboardOnBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapBackground() {
        self.view.endEditing(true)
    }
}
