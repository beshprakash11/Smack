//
//  GradientView.swift
//  Smack
//
//  Created by Besh Prakash  on 09.08.22.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    // MARK: TOPGRADIENT_COLOR
    /// Define topColor in Gradient
    ///  ```
    ///  topColor: -> (Color.blue)
    ///  ```
    ///  This color can be changeable.
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0.2901960784, green: 0.3019607843, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    // MARK: BOTTOMGRADIENT_COLOR
    /// Define bottomColor in Gradient Color
    /// ```
    /// bottomColor -> (Color.green)
    /// ```
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.1725490196, green: 0.831372549, blue: 0.8470588235, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }// end bottomColor

    // MARK: APPLYGRADIENT_COLOR
    /// Here, we implement the topColor and bottomColor
    ///  ```
    ///  layoutSubviews() -> {
    ///           let gradientLayer = CAGradientLayer()
    ///           gradientLayer.colors = [topColor.cgColor,bottomColor.cgColor,...]
    ///  }
    ///  ```
    ///  Define startpoint CGPoint(x:0, y:0) and endpoint CGPoint(x: 1, y:1).
    ///  Then apply top and bottom color to given UI.
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
