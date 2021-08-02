//
//  CollHome.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/14/21.
//

import UIKit

final class CollHome: UICollectionView {
    
    var homeData = [HomeCollection]()
    
    private let images = [UIImage(named: "ic_BigOne"), UIImage(named: "ic_read"), UIImage(named: "ic_read"), UIImage(named: "ic_bigA"), UIImage(named: "ic_read"), UIImage(named: "ic_read")]
    
    private let animationDuration: Double = 1.0
    private let delayBase: Double = 0.4
    
    private var indexPathForSelectedCell = [IndexPath(item: 0, section: 0)]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
}

//MARK:- Configure
//MARK:-
extension CollHome {
    
    private func configure() {
        
        dataSource = self
        delegate = self
        register(HomeCell.nib, forCellWithReuseIdentifier: HomeCell.identifier)
    }
}

//MARK:- UICollectionView DataSource and Delegate Methods.
//MARK:-
extension CollHome: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell {
            
            let data = homeData[indexPath.row]
            homeCell.configureCell(img: data.image, title: data.title, subTitle: data.subTitle)
            
            return homeCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.setAlphaValue(alpha: 0.0)
        cell.transform = CGAffineTransform(translationX: 0, y: 300)
        let delay = sqrt(Double(indexPath.item)) * delayBase + 0.2
        
        UIView.animate(withDuration: animationDuration, delay: delay, animations: { [weak self] in
            
            if let homeCell = cell as? HomeCell {
                
                homeCell.setAlphaValue(alpha: 1.0)
                homeCell.transform = CGAffineTransform(translationX: 0, y: 0)
                self?.layoutIfNeeded()
            }
            
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        indexPathForSelectedCell.append(indexPath)
        
        if let homeCell = collectionView.cellForItem(at: indexPath) as? HomeCell {
            
            let lblText = homeCell.lblTitle.text ?? ""
            
            checkSelectedCell(lbltext: lblText, homeCell: homeCell, row: indexPath.row)
        }
    }
    
    //MARK: Flow Layout Delegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CScreenWidth * (177/414) - 12, height: CScreenWidth * (200/414))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
}

//MARK:- Helper / Navigation Methods
//MARK:-
extension CollHome {
    
    private func checkSelectedCell(lbltext: String, homeCell: HomeCell, row: Int) {
        
        let homeSelectection = HomeSelection(rawValue: lbltext)
        
        switch homeSelectection {
        
        case .numbers:
            
            configureSelectedCell(identifier: .NumbersVC, homeCell: homeCell, img: images[row] ?? UIImage())
            
        case .reading:
            return
        case .shapes:
            return
        case .vocabLetters:
            return
        case .learningAnalysis:
            return
        case .settings:
            return
        case .none:
            break
        }
    }
    
    private func configureSelectedCell(identifier: UIStoryboard.Identifier, homeCell: HomeCell, img: UIImage) {
        
        self.isUserInteractionEnabled = false
        
        if homeCell.isSelectedCell {
            gotoDetailVC(identifier: identifier)
        } else {
            homeCell.configureDidSelectCell(img: img)
        }
    }
    
    private func gotoDetailVC(identifier: UIStoryboard.Identifier) {
        
        if let homeVC = UIApplication.topViewController() as? HomeVC {
            
            let detailVC = CMainStoryboard.instantiateViewControllerWithIdentifier(identifier: identifier)
            homeVC.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    // Reset CollectionView and cell back to its state
    func resetCollectionCell() {
        
        self.isUserInteractionEnabled = true
        
        for indexpath in indexPathForSelectedCell {
            
            if let homeCell = self.cellForItem(at: indexpath) as? HomeCell {
                
                let data = homeData[indexpath.row]
                homeCell.configureCell(img: data.image, title: data.title, subTitle: data.subTitle)
                homeCell.isSelectedCell = false
            }
        }
    }
}
