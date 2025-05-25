//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Surajit Shaw on 25/05/25.
//

import UIKit

extension UIViewController {
    func showAlert(
        title: String = "Error",
        message: String = "Something went wrong.",
        actionTitle: String = "OK",
        style: UIAlertAction.Style = .default
    ) {
        // If already on main thread, execute immediately
        if Thread.isMainThread {
            presentAlert(title: title, message: message, actionTitle: actionTitle, style: style)
        } else {
            DispatchQueue.main.async {
                self.presentAlert(title: title, message: message, actionTitle: actionTitle, style: style)
            }
        }
    }
    
    private func presentAlert(
        title: String,
        message: String,
        actionTitle: String,
        style: UIAlertAction.Style
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: style))
        self.present(alert, animated: true)
    }
}

