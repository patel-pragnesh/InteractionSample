//
//  SlideScrollSampleViewController.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/16.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SlideScrollSampleViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerView: ScrollHeaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            .asObservable()
            .map { $0.x / self.SCREENWIDTH }
            .subscribeNext { (x) in
                self.headerView.transformIcon(position: x)
            }
            .addDisposableTo(disposeBag)
    }
    
    private func goToPrev() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}
