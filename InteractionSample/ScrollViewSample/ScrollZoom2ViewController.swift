//
//  ScrollZoom2ViewController.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/17.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ScrollZoom2ViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageHeightConst: NSLayoutConstraint!
    
    private let IMAGEVIEWHEIGHT: CGFloat = UIScreen.mainScreen().bounds.size.width
    private let disposeBag               = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageHeightConst.constant = IMAGEVIEWHEIGHT
        binding()
    }
    
    private func binding() {
        backButton.rx_tap
            .asObservable()
            .subscribeNext { (_) in
                self.goToPrev()
            }
            .addDisposableTo(disposeBag)
    }
    
    private func goToPrev() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
