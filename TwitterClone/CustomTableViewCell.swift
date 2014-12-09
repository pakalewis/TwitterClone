//
//  File.swift
//  TwitterClone
//
//  Created by Parker Lewis on 10/7/14.
//  Copyright (c) 2014 Parker Lewis. All rights reserved.
//

import Foundation
import UIKit

class CustomTableViewCell : UITableViewCell {
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var cellText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

