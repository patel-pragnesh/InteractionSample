//
//  ScrollViewType.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/15.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit

enum ScrollViewType {
    case ScrollZoom
    
    var name: String {
        switch self {
        case .ScrollZoom:
            return "ScrollZoom"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .ScrollZoom:
            guard let vc = R.storyboard.scrollViewSample.scrollZoomViewController() else { return UIViewController() }
            return vc
        }
    }
}
