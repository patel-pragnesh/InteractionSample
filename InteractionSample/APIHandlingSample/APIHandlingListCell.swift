//
//  APIHandlingListCell.swift
//  InteractionSample
//
//  Created by 村田裕馬 on 2016/06/21.
//  Copyright © 2016年 ymurata. All rights reserved.
//

import UIKit

class APIHandlingListCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(title title: String) {
        titleLabel.text = title
    }
}
