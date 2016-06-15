//
//  ScrollZoomViewController.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/15.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ScrollZoomViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var zoomViewTopConst: NSLayoutConstraint!
    @IBOutlet weak var imageBaseViewHeightConst: NSLayoutConstraint!
    
    private let IMAGEVIEWHEIGHT: CGFloat = UIScreen.mainScreen().bounds.size.width
    private let ZOOMVIEWHEIGHT: CGFloat  = 205
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageBaseViewHeightConst.constant = IMAGEVIEWHEIGHT
        binding()
    }

    
    private func binding() {
        backButton.rx_tap
            .asObservable()
            .subscribeNext { (_) in
                self.goToPrev()
            }
            .addDisposableTo(disposeBag)
        
        scrollView.rx_contentOffset
            .asDriver()
            .map { $0.y + (self.IMAGEVIEWHEIGHT - self.ZOOMVIEWHEIGHT)/2 }
            .filter { $0 <= 0 }
            .drive(zoomViewTopConst.rx_constant)
            .addDisposableTo(disposeBag)
        scrollView.rx_contentOffset
            .asDriver()
            .map { $0.y + self.IMAGEVIEWHEIGHT - self.ZOOMVIEWHEIGHT}
            .filter { $0 <= 0 }
            .map { self.IMAGEVIEWHEIGHT - $0 }
            .drive(imageBaseViewHeightConst.rx_constant)
            .addDisposableTo(disposeBag)
    }
    
    private func goToPrev() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
