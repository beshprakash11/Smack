//
//  LabelView.swift
//  Smack
//
//  Created by Besh Prakash  on 22.08.22.
//

import UIKit

@IBDesignable
class LabelView: UILabel {
    @IBInspectable var cornerRadius: CGFloat = 10 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }
    func setupView(){
        self.layer.cornerRadius = cornerRadius
    }


}
