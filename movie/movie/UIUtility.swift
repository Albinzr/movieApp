//
//  UIUtility.swift
//  movie
//
//  Created by Albin on 02/08/16.
//  Copyright © 2016 Albin. All rights reserved.
//

import Foundation
import UIKit


class UIUtility{
    
    // MARK: - Change border style
    
    func borderEffect(textField:UITextField) -> Void {
        
        let borderColor:UIColor = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1)
        
        //Bottom Bar
        let borderWidth:CGFloat = 1.0
        let userNameBottomborder = CALayer()
        userNameBottomborder.borderColor = borderColor.CGColor
        userNameBottomborder.frame = CGRect(x: 0, y: textField.frame.size.height - borderWidth, width:  textField.frame.size.width, height: borderWidth)
        userNameBottomborder.borderWidth = borderWidth
        textField.layer.addSublayer(userNameBottomborder)
        
        //left Border
        let userNameLeftborder = CALayer()
        userNameLeftborder.borderColor = borderColor.CGColor
        userNameLeftborder.frame = CGRect(x: 0, y: CGRectGetHeight(textField.frame)/2, width:borderWidth, height: CGRectGetHeight(textField.frame))
        userNameLeftborder.borderWidth = borderWidth
        textField.layer.addSublayer(userNameLeftborder)
        
        //Right Border
        let userNameRightborder = CALayer()
        userNameRightborder.borderColor = borderColor.CGColor
        userNameRightborder.frame = CGRect(x: CGRectGetWidth(textField.frame) - 1, y: CGRectGetHeight(textField.frame)/2, width:borderWidth, height: CGRectGetHeight(textField.frame))
        userNameRightborder.borderWidth = borderWidth
        textField.layer.addSublayer(userNameRightborder)
        
    }
    
    func setNavigationBar(navigationController:UINavigationController) -> Void{
        
        let navigationBarBackgroundColor :UIColor! = UIColor(hexString: "F5F5F5")
        navigationController.navigationBar.barTintColor = navigationBarBackgroundColor
        
        let navigationBarTitlesColor :UIColor! = UIColor(hexString: "4A4A4A")
        navigationController.navigationBar.tintColor = navigationBarTitlesColor
        
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: navigationBarTitlesColor]
        
        navigationController.navigationBar.translucent = false
        
        navigationController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
        
    }
    
    
}