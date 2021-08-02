//
//  NumbersAnimation.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/29/21.
//

import UIKit

extension NumbersVC {
    
    func animateViews(btnBack: UIButton, lblNumbers: UILabel, lblNumberDesc: UILabel, vcView: UIView, constBtnBackTop: NSLayoutConstraint, collNumbers: CollNumbers, smallNumbersData: [SmallNumbers]) {
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseInOut, animations: {
            
            constBtnBackTop.constant = 11
            
            btnBack.setAlphaValue(alpha: 1)
            lblNumbers.setAlphaValue(alpha: 1)
            lblNumberDesc.setAlphaValue(alpha: 1)
            
            vcView.layoutIfNeeded()
            
        }, completion: { _ in
            
            collNumbers.numbersData = smallNumbersData
            collNumbers.reloadData()
        })
    }
}
