//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Besh Prakash  on 10.08.22.
//

import UIKit
import Starscream

class CreateAccountVC: UIViewController {

    // MARK: OUTLETS
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    
    @IBOutlet weak var userImg: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    //valirables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var bgColor : UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupView()
    }
    
    // MARK: BACKFROM_CREATEACCOUNT
    /// Retrurn back fraom create account section to the main screen i.e. chanel screen
    /// ```
    /// closedPressed(_ sender: Any)
    /// ```
    /// Uses identifier defined by constant "UNWIND"
    @IBAction func closedPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
        }
        
        if avatarName.contains("light") && bgColor == nil {
            userImg.backgroundColor = UIColor.lightGray
        }
    }
    
    
    @IBAction func createAccountPressed(_ sender: Any) {
        //spiner sow
        spinner.isHidden = false
        spinner.startAnimating()
        
        guard
            let name = usernameText.text, usernameText.text != "",
            let email = emailText.text, emailText.text != "",
            let pass = passText.text, passText.text != ""
        else{ return }
        
        AuthService.instance.registerUser(email: email, password: pass) { success in
            if success{
                AuthService.instance.loginUser(email: email, password: pass, completion: {success in
                    if success{
                        //print("logged in user!", AuthService.instance.authToken)
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                // sending out notification
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                            }
                             
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    
    
    @IBAction func pickBGColorPressed(_ sender: Any) {
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        avatarColor = "[\(r),\(g),\(b),1]"
        
        UIView.animate(withDuration: 0.2){
            self.userImg.backgroundColor = self.bgColor
        }
        
    }
    
    func setupView(){
        spinner.isHidden = true
        // settting up colors
        usernameText.attributedPlaceholder = NSAttributedString(string: "Username here..", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        emailText.attributedPlaceholder = NSAttributedString(string: "Email here...", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        passText.attributedPlaceholder = NSAttributedString(string: "Password here..", attributes: [NSAttributedString.Key.foregroundColor:smackPurplePlaceholder])
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
        
    }
    @objc func handleTap(){
        view.endEditing(true)
    }
}

extension CreateAccountVC{
    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    
}
