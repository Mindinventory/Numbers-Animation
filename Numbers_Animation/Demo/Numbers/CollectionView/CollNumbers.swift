//
//  CollNumbers.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/26/21.
//

import UIKit

final class CollNumbers: UICollectionView {
    
    var numbersData = [SmallNumbers]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
}

//MARK:- Configure
//MARK:-
extension CollNumbers {
    
    private func configure() {
        
        dataSource = self
        delegate = self
        register(NumbersCell.nib, forCellWithReuseIdentifier: NumbersCell.identifier)
    }
}

//MARK:- UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout Methods
//MARK:-
extension CollNumbers: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numbersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let numbersCell = collectionView.dequeueReusableCell(withReuseIdentifier: NumbersCell.identifier, for: indexPath) as? NumbersCell {
            
            numbersCell.configureCell(image: numbersData[indexPath.row].image)
            return numbersCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.transform = CGAffineTransform(translationX: 0, y: 300)
        
        let delay = sqrt(Double(indexPath.row)) * 0.5
        
        UIView.animate(withDuration: 0.8, delay: delay, options: .curveEaseOut,  animations: { [weak self] in
            
            if let numbersCell = cell as? NumbersCell {
                
                numbersCell.transform = CGAffineTransform(translationX: 0, y: 0)
                self?.layoutIfNeeded()
            }
            
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let numbersCell = self.cellForItem(at: indexPath) as? NumbersCell {
            
            animateCell(row: indexPath.row, numberCell: numbersCell)
        }
    }
    
    //MARK: CollectionView FlowLayout Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = (CScreenWidth / 5) - 38
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 20, left: 30, bottom: 42, right: 30)
    }
}

//MARK:- Animatation Methods
//MARK:-
extension CollNumbers {
    
    private func animateCell(row: Int, numberCell: NumbersCell) {
        
        self.isUserInteractionEnabled = false
        
        if let numbersVC = UIApplication.topViewController() as? NumbersVC {
            
            numbersVC.lblNumberDetail.isHidden = true
            numbersVC.constLblNumberDetailCenterX.constant = numbersVC.view.center.x + 300
            numbersVC.vwNumberAnimate.isHidden = false
            numbersVC.imgNumber.isHidden = true
            
            let image = numbersData[row].image
            let imgView = UIImageView(image: image)
            
            numbersVC.vwNumberAnimate.frame = self.superview?.convert(numberCell.frame, from: self) ?? CGRect()
            imgView.frame = CGRect(x: 0, y: 0, width: numbersVC.vwNumberAnimate.frame.width, height: numbersVC.vwNumberAnimate.frame.height)
            numbersVC.vwNumberAnimate.addSubview(imgView)
            
            numbersVC.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 1.0, delay: 0.2, options: .curveEaseInOut, animations: {
                
                numbersVC.vwNumberAnimate.frame = numbersVC.imgNumber.frame
                imgView.frame = CGRect(x: 0, y: 0, width: numbersVC.vwNumberAnimate.frame.width, height: numbersVC.vwNumberAnimate.frame.height)
                
                numbersVC.lblNumberDetail.isHidden = false
                numbersVC.constLblNumberDetailCenterX.constant = 0
                
                numbersVC.view.layoutIfNeeded()
                
            }, completion: { _ in
                
                numbersVC.imgNumber.image = imgView.image
                numbersVC.imgNumber.isHidden = false
                numbersVC.vwNumberAnimate.subviews.forEach { $0.removeFromSuperview() }
                numbersVC.vwNumberAnimate.isHidden = true
                self.isUserInteractionEnabled = true
            })
        }
    }
}
