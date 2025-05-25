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
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: style))
        present(alert, animated: true)
    }
}
