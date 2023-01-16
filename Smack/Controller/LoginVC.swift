//
//  LoginVC.swift
//  Smack
//
//  Created by Besh Prakash  on 10.08.22.
//

import UIKit

class LoginVC: UIViewController {
    // MARK: LOGINVC_OUTLET
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: LOGIN_ACTION
    @IBAction func loginPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard
            let email = usernameText.text, usernameText.text != "",
            let pass = passwordText.text, passwordText.text != ""
        else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success{
                AuthService.instance.findUserByEmail(completion: {(success) in
                    if success{
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.spinner.isHidden = true
                        self.spinner.stopAnimating()
                        self.dismiss(animated: true,completion: nil)
                    }
                })
            }
        }
    }
    
    
    

    // MARK: LoginClosed
    /// ```
    /// closePressed(_ sender: Any) --> ChannelScreen
    /// ```
    /// When this button is pressed, login screen is closed and return back to the channel view screen.
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: CREATEACCOUNT_BUTTON
    /// Goto CREATE_ACCOUNT  SCREEN
    /// ```
    /// createAccountBtnPressed(_ sender: Any) -> RESGISTER_USER_SCREEN
    /// ```
    /// When you pressed this button, UI navigate you toward the create account screen.
    /// And you can resigter your user name and password.
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    func setupView(){
        spinner.isHidden = true
        // settting up colors
        usernameText.attributedPlaceholder = NSAttributedString(string: "Username here..", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        passwordText.attributedPlaceholder = NSAttributedString(string: "Password here..", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        
    }
    
}
