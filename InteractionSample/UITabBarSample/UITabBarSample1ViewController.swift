//
//  UITabBarSample1ViewController.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/16.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UITabBarSample1ViewController: UIViewController {
    
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var pushNexPageButton: UIButton!
    
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
        pushNexPageButton.rx_tap
            .asObservable()
            .subscribeNext { (_) in
                self.goToNext()
            }
            .addDisposableTo(disposeBag)
    }
    
    private func goToPrev() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func goToNext() {
        guard let vc = R.storyboard.scrollViewSample.scrollZoomViewController() else { return }
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
