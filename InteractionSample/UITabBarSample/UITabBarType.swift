//
//  UITabBarType.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/16.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit

enum UITabBarType {
    case TabBarHide
    
    var name: String {
        switch self {
        case .TabBarHide:
            return "TabBarHide"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .TabBarHide:
            guard let vc = R.storyboard.uITabBarSample.pushHideTabBarController() else { return UIViewController() }
            return vc
        }
    }
}
