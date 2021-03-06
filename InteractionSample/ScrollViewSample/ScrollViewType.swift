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
    case ScrollZoom2
    case SlideScroll
    
    var name: String {
        switch self {
        case .ScrollZoom:
            return "ScrollZoom"
        case .ScrollZoom2:
            return "ScrollZoom2"
        case .SlideScroll:
            return "SlideScroll"
        }
    }
    
    var viewController: UIViewController {
        switch self {
        case .ScrollZoom:
            guard let vc = R.storyboard.scrollViewSample.scrollZoomViewController() else { return UIViewController() }
            return vc
        case .ScrollZoom2:
            guard let vc = R.storyboard.scrollViewSample.scrollZoom2ViewController() else { return UIViewController() }
            return vc
        case .SlideScroll:
            guard let vc = R.storyboard.scrollViewSample.slideScrollSampleViewController() else { return UIViewController() }
            return vc
        }
    }
}
