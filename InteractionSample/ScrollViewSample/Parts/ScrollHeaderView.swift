//
//  ScrollHeaderView.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/16.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit


class ScrollHeaderView: UIView {
    
    @IBOutlet weak var imageBaseView: UIView!
    @IBOutlet weak var sample1ImageView: UIImageView!
    @IBOutlet weak var sample2ImageView: UIImageView!
    @IBOutlet weak var sample3ImageView: UIImageView!
    
    private let SCREENWIDTH = UIScreen.mainScreen().bounds.size.width
    
    override func awakeFromNib() {
        guard let view = R.nib.scrollHeaderView.firstView(owner: self) else { return }
        self.addSubview(view)
        transformIcon(position: 0)
    }
    
    func transformIcon(position position: CGFloat) {
        for view in imageBaseView.subviews {
            let x = position - CGFloat(view.tag - 1)
            view.transform = CGAffineTransformMakeTranslation((34 - SCREENWIDTH / 2)*x, 0)
            view.transform = CGAffineTransformScale(view.transform, 1 - abs(x) * 0.3, 1 - abs(x) * 0.3)
        }
    }
}
