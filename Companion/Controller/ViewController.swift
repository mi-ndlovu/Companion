//
//  ViewController.swift
//  Companion
//
//  Created by Mbongeni NDLOVU on 2018/10/16.
//  Copyright © 2018 mndlovu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, API42Delegate {
    
    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var mySpinner: UIActivityIndicatorView!
    var api = APIController.api42
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.delegate = self
        myTextField.delegate = self
        myView.layer.cornerRadius = 8
        mySpinner.hidesWhenStopped = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func alertUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        present(alert,animated: true, completion: nil)
    }
    
    func handleUser(User user: UserInfo) {
        mySpinner.stopAnimating()
        performSegue(withIdentifier: "moveToTabBar", sender: user)
    }
    
    func handleError(Errors error: String) {
        mySpinner.stopAnimating()
        self.alertUser(title: "Error", message: error)
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let login = textField.text!
        if login != "" {
            api.loginAuth(Login: login)
            mySpinner.startAnimating()
        }
        return textField.resignFirstResponder()
    }
}
