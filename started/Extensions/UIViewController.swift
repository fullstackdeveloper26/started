//
//  UIViewController.swift
//  Extentions
//
//  Created by Rener on 7/20/20.
//  Copyright © 2020 ExtremeMobile. All rights reserved.
//

import MBProgressHUD
import UIKit

extension UIViewController{

    func showToast(message : String, isError : Bool = true, complete:(() -> Void)? = nil) {
        let screenWidth = Int(UIScreen.main.bounds.width)
        let screenHeight = Int(UIScreen.main.bounds.height)
        
        let toastHeight = 45
        var bottomSafeArea = 0
        
        if #available(iOS 11.0, *) {
            bottomSafeArea = Int(self.view.safeAreaInsets.bottom)
        } else {
            bottomSafeArea = Int(self.bottomLayoutGuide.length)
        }

        let toastLabel = UILabel(frame: CGRect(x: 0, y: (screenHeight - bottomSafeArea - toastHeight) , width: screenWidth, height: toastHeight))
        toastLabel.backgroundColor = isError ? "C44141".hexStringToUIColor() : "41A317".hexStringToUIColor()
        toastLabel.attributedText = message.convertHtmlToAttributedStringWithCSS(font: UIFont(name: "Avenir-Medium", size: 14)!, csscolor: "#FFFFFF", lineheight: 18, csstextalign: "center")
        toastLabel.numberOfLines = 2
        toastLabel.alpha = 1.0
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1, delay: 1.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
            if complete != nil
            {
                complete!()
            }
        })
    }
    
}
