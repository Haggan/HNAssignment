//
//  HNCollectionViewCell.swift
//  HNAssignment
//
//  Created by Robert Hagklint on 2018-10-06.
//  Copyright © 2018 Robert Hagklint. All rights reserved.
//

import UIKit

/**
 Due to time constraints and that I can't run the application on a real device atm, I haven't been
 able to test performance like I would like to. Is a coverView with alpha value below 1 more performant than
 having all the different views change their alpha? If we change the alpha of all the views in the cell
 and remove the coverview, it could possibly mean less complex draw calls.
 The coverView drawcall could actually be pretty complex since the alpha value means it has to draw
 several views underneath it
 */

class HNCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topCollection: LabelCollection!
    @IBOutlet weak var bottomCollection: LabelCollection!
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var removedLabel: UILabel!
    
    var thumbnailIdentifier: String?
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted == true {
                contentView.backgroundColor = .lightGray
                contentView.alpha = 0.5
            } else {
                contentView.backgroundColor = .white
                contentView.alpha = 1
            }
        }
    }
}
