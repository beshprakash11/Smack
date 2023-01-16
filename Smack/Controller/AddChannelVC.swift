//
//  AddChannelVC.swift
//  Smack
//
//  Created by Besh Prakash  on 22.08.22.
//

import UIKit

class AddChannelVC: UIViewController {
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var chanDesc: UITextField!
    
    @IBOutlet weak var bgView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }


    @IBAction func createChannelPressed(_ sender: Any) {
        guard
            let channelName = nameText.text, nameText.text != "",
            let channelDesc = chanDesc.text, chanDesc.text != ""
        else { return }
        
        
        SocketService.instance.addChannel(channelName: channelName, channelDescription: channelDesc) { (success) in
            
            if success {
                self.dismiss(animated: true, completion: nil)
               debugPrint("Create channel button pressed \(success)")
            }
        }
    }
    
    @IBAction func closeModalPressed(_ sender: Any) {
        debugPrint("Button closed pressed")
        dismiss(animated: true, completion: nil)
    }
    
    func setupView(){
        let closedTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelVC.closeTap(_:)))
        bgView.addGestureRecognizer(closedTouch)
        nameText.attributedPlaceholder = NSAttributedString(string: "Name...",attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        chanDesc.attributedPlaceholder = NSAttributedString(string: "Channel Description...",attributes: [NSAttributedString.Key.foregroundColor: smackPurplePlaceholder])
        
    }
    
    
    @objc func closeTap(_ recognizer: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}
