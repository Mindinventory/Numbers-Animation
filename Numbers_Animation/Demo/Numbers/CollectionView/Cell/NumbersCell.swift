//
//  NumbersCell.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/26/21.
//

import UIKit

final class NumbersCell: UICollectionViewCell {
    
    @IBOutlet weak private var imgNumber: UIImageView!
}

//MARK:- Configure
//MARK:-
extension NumbersCell {
    
    func configureCell(image: UIImage) {
        
        imgNumber.image = image
    }
}
