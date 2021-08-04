//
//  NumbersVC.swift
//  Kids_Animation
//
//  Created by mind-288 on 7/26/21.
//

import UIKit

final class NumbersVC: UIViewController {

    @IBOutlet weak var constBtnBackLeading: NSLayoutConstraint!
    @IBOutlet weak private var btnBack: UIButton!
    @IBOutlet weak private var collNumbers: CollNumbers!
    @IBOutlet weak private var lblNumbers: UILabel!
    @IBOutlet weak private var lblNumberDesc: UILabel!
    @IBOutlet weak var lblNumberDetail: UILabel!
    @IBOutlet weak var imgNumber: UIImageView!
    @IBOutlet weak var vwNumberAnimate: UIView!
    @IBOutlet weak private var constBtnBackTop: NSLayoutConstraint!
    @IBOutlet weak private var constCollNumberHeight: NSLayoutConstraint!
    @IBOutlet weak private var constImgNumberTop: NSLayoutConstraint!
    @IBOutlet weak var constLblNumberDetailCenterX: NSLayoutConstraint!

    private let smallNumbersData = [SmallNumbers(image: UIImage(named: "ic_small0") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_BigOne") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small2") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small3") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small4") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small5") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small6") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small7") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small8") ?? UIImage()),
                                    SmallNumbers(image: UIImage(named: "ic_small9") ?? UIImage())]

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Configure -
extension NumbersVC {

    private func configure() {

        lblNumbers.changeFontSize(size: CScreenWidth * (36/414), weight: .regular)
        lblNumberDesc.changeFontSize(size: CScreenWidth * (20/414), weight: .light)
        lblNumberDetail.changeFontSize(size: CScreenWidth * (30/414), weight: .regular)

        imgNumber.isHidden = true
        lblNumberDetail.isHidden = true

        btnBack.setAlphaValue(alpha: 0)
        lblNumbers.setAlphaValue(alpha: 0)
        lblNumberDesc.setAlphaValue(alpha: 0)

        constBtnBackTop.constant = 150
        constBtnBackLeading.constant = CScreenWidth * (30/414)
        constImgNumberTop.constant = CScreenHeight * (217/896)

        setAttributedTextonLbls()

        CMainThread.asyncAfter(deadline: .now() + 0.2, execute: {

            self.animateViews(btnBack: self.btnBack, lbls: (self.lblNumbers, self.lblNumberDesc),
                              vcView: self.view, constBtnBackTop: self.constBtnBackTop,
                              coll: (self.collNumbers, self.smallNumbersData))
        })
    }

    private func setAttributedTextonLbls() {

        let attrStr = NSMutableAttributedString(string: lblNumberDetail.text ?? "")
        attrStr.addAttribute(.foregroundColor,
                             value: UIColor.init(red: 255/255, green: 111/255, blue: 77/255, alpha: 1),
                             range: NSRange(location: 1, length: 1))
        attrStr.addAttribute(.foregroundColor,
                             value: UIColor.init(red: 255/255, green: 179/255, blue: 87/255, alpha: 1),
                             range: NSRange(location: 5, length: 3))
        attrStr.addAttribute(.font, value: UIFont.systemFont(ofSize: CScreenWidth * (30/414), weight: .black),
                             range: NSRange(location: 1, length: 1))

        lblNumberDetail.attributedText = attrStr
    }
}

// MARK: - Button's Actions -
extension NumbersVC {

    @IBAction func onBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
