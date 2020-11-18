//
//  UIViewControllerExtension.swift
//  DeckOfOneCard
//
//  Created by Michael Nguyen on 11/17/20.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentErrorToUser(localizedError: LocalizedError) {

        let alertController = UIAlertController(title: "Error", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
