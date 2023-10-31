//
//  UserInfoPage.swift
//  OPS
//
//  Created by changxing on 5/2/21.
//

import PinLayout
import UIKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct UserInfoPage_PreView: PreviewProvider {
    static var previews: some View {
            ViewControllerPreview {
                UINavigationController(rootViewController: UserInfoPage())
            }
            .previewDevice("iPhone Xʀ")
    }
}
#endif


class UserInfoPage: ThemedUIViewController{
    //用户信息
    let userBackground = UIImageView()
    let userHead = UIImageView()
    let userName = UILabel()
    let userId = UILabel()
    let userDiscription = UILabel()
    //个人链接
    let linkIconLeft = UIImageView()
    let linkIconRight = UIImageView()
    let linkVector = UIImageView()
    let userLink = UILabel()
    //加入日期
    let badgeIcon = UIImageView()
    let badgeNum = UILabel()
    let joinDate = UILabel()
    //关注数目
    let followingNum = UILabel()
    let followerNum = UILabel()
    //修改个人信息
    let editProfileButton = UIButton()
    let profileIcon = UIImage(named: "profileIcon")

    // oCard 组件
    let oCardView = UIView()
    let oCardRectangle = UIImageView()
    let oCardTitle = UILabel()
    let availableLabel = UILabel()
    let available = UILabel()
    let priceLabel = UILabel()
    let price = UILabel()
    let manageBackground = UIImage(named: "manageButton")
    let mintBackgound = UIImage(named: "mintButton")
    let manageButton = UIButton()
    let mintButton = UIButton()
    
    //balanceCard 组件
    let balanceCardView = UIView()
    let balanceCardRectangle = UIImageView()
    let balanceLabel = UILabel()
    let balance = UILabel()
    let depositBackground = UIImage(named: "depositBackground")
    let withdrawBackground = UIImage(named: "withdrawBackground")
    let depositButton = UIButton()
    let withdrawButton = UIButton()
    
    //提示信息
    let additionInfo = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        //用户信息
        userBackground.image = UIImage(named: "userBackground")
        userHead.image = UIImage(named: "avator")
        userHead.layer.cornerRadius = 40
        userHead.layer.masksToBounds = true
        userName.font = MyThemes.fontWithLanguage(size: 20, weight: .semibold)
        userName.theme_textColor = MyThemes.normalTextColor
        userName.text = "Real Splatooner"

        userId.font = MyThemes.fontWithLanguage(size: 12)
        userId.theme_textColor = MyThemes.grayTextColor
        userId.text = "@Pink_pill"
        
        userDiscription.font = MyThemes.fontWithLanguage(size: 14)
        userDiscription.theme_textColor = MyThemes.normalTextColor
        userDiscription.numberOfLines = 0
        userDiscription.lineBreakMode = .byWordWrapping
        
        userDiscription.text = "French Concept artist/Art director and founder of@UmeshuLovers, vis dev studio (formerly Guerrilla Games, Rocksteady, Ubi, Sony) We still have lots of things to reveal during ......."

        //个人链接
        linkIconLeft.image = UIImage(named: "linkIconLeft")
        linkIconRight.image = UIImage(named: "linkIconRight")
        linkVector.image = UIImage(named: "linkVector")
        
        userLink.font = MyThemes.fontWithLanguage(size: 12)
        userLink.theme_textColor = MyThemes.grayTextColor
        userLink.text = "artstation.com/artist/tohad"
        
        //badge 
        badgeIcon.image = UIImage(named: "badgeIcon")
        badgeNum.font = MyThemes.fontWithLanguage(size: 10)
        badgeNum.theme_textColor = MyThemes.grayTextColor
        badgeNum.text = "15"
        
        //加入日期label
        joinDate.font = MyThemes.fontWithLanguage(size: 10)
        joinDate.theme_textColor = MyThemes.grayTextColor
        joinDate.text = "Joined May 2011"
        
        //关注信息
        followingNum.font = MyThemes.fontWithLanguage(size: 10)
        followingNum.theme_textColor = MyThemes.grayTextColor
        followingNum.text = "134,177 Following"

        followerNum.font = MyThemes.fontWithLanguage(size: 10)
        followerNum.theme_textColor = MyThemes.grayTextColor
        followerNum.text = "13.8K Followers"
        
        //编辑个人信息按钮
        editProfileButton.setImage(profileIcon, for: .normal)
        editProfileButton.setTitle("Edit Profile", for: .normal)

        editProfileButton.theme_backgroundColor = MyThemes.activeTextColor
        editProfileButton.layer.masksToBounds = true
        editProfileButton.layer.cornerRadius = 10
        
        //oCard 卡片部分
        oCardRectangle.image = UIImage(named: "oCardRectangle")
        oCardRectangle.layer.cornerRadius = 20
        oCardTitle.theme_textColor = MyThemes.activeTextColor
        oCardTitle.font = MyThemes.fontWithLanguage(size:24)
        oCardTitle.text = "My oCards "

        availableLabel.font = MyThemes.fontWithLanguage(size: 14)
        availableLabel.theme_textColor = MyThemes.normalTextColor
        availableLabel.text = "Available: "
        available.font = MyThemes.fontWithLanguage(size:14)
        available.theme_textColor = MyThemes.normalTextColor
        available.text = "16"

        priceLabel.font = MyThemes.fontWithLanguage(size: 12)
        priceLabel.theme_textColor = MyThemes.normalTextColor
        priceLabel.text = "Price(OPS Points ea):"
        price.font = MyThemes.fontWithLanguage(size: 12)
        price.theme_textColor = MyThemes.normalTextColor
        price.text = "9,000,000.255"

        manageButton.setBackgroundImage(manageBackground, for: .normal)
        manageButton.setTitle("manage", for: .normal)
//        manageButton.setTitleColor(MyThemes.normalTextColor, for: .normal)
        mintButton.setBackgroundImage(mintBackgound, for: .normal)
        mintButton.setTitle("mint", for: .normal)

        //balanceCardView
        balanceCardRectangle.image = UIImage(named: "balanceCardRectangle")
        balanceLabel.font = MyThemes.fontWithLanguage(size: 14)
        balanceLabel.theme_textColor = MyThemes.normalTextColor
        balanceLabel.text = "OPS Points Balance:"
        balance.font = MyThemes.fontWithLanguage(size: 14)
        balance.theme_textColor = MyThemes.grayTextColor
        balance.text =  "333221321213120.00579"

        depositButton.setBackgroundImage(manageBackground, for: .normal)
        depositButton.setTitle("Deposit", for: .normal)
        withdrawButton.setBackgroundImage(mintBackgound, for: .normal)
        withdrawButton.setTitle("Withdraw", for: .normal)

       //附加提示 
        additionInfo.font = MyThemes.fontWithLanguage(size: 12)
        additionInfo.theme_textColor = MyThemes.grayTextColor
        additionInfo.text = "Want a promote? Make an airdrop!"
        
        view.addSubview(userBackground)
        view.addSubview(userHead)
        view.addSubview(userName)
        view.addSubview(userId)
        view.addSubview(userDiscription)
        view.addSubview(linkIconLeft)
        view.addSubview(linkVector)
        view.addSubview(linkIconRight)
        view.addSubview(userLink)
        view.addSubview(badgeIcon)
        view.addSubview(badgeNum)
        view.addSubview(joinDate)
        view.addSubview(followingNum)
        view.addSubview(followerNum)
        view.addSubview(editProfileButton)
        //oCardView
        oCardView.addSubview(oCardRectangle)
        oCardView.addSubview(oCardTitle)
        oCardView.addSubview(availableLabel)
        oCardView.addSubview(available)
        oCardView.addSubview(priceLabel)
        oCardView.addSubview(price)
        oCardView.addSubview(manageButton)
        oCardView.addSubview(mintButton)
        view.addSubview(oCardView)

        //balanceCard 组件
        balanceCardView.addSubview(balanceCardRectangle)
        balanceCardView.addSubview(balanceLabel)
        balanceCardView.addSubview(balance)
        balanceCardView.addSubview(depositButton)
        balanceCardView.addSubview(withdrawButton)
        view.addSubview(balanceCardView)

        //附加信息提示
        view.addSubview(additionInfo)

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userBackground.pin.sizeToFit().top(view.pin.layoutMargins).height(180).left(0).right(0)
        userHead.pin.sizeToFit().below(of: userBackground).height(80)
            .left(15).marginTop(-40)
        userName.pin.sizeToFit().right(of: userHead).below(of: userBackground).marginLeft(5)
        userId.pin.sizeToFit().below(of: userName, aligned: .left)
        userDiscription.pin.below(of: userBackground, aligned: .left).marginLeft(15).width(345).pinEdges().marginTop(55).sizeToFit(.width)

        linkIconLeft.pin.sizeToFit().below(of: userDiscription,aligned: .left).marginTop(15)
        linkVector.pin.sizeToFit().below(of: userDiscription).right(of: linkIconLeft).marginTop(20).marginLeft(-4)
        linkIconRight.pin.sizeToFit().below(of: userDiscription).right(of: linkVector).marginLeft(-4).marginTop(15)

        userLink.pin.sizeToFit().right(of: linkIconRight, aligned: .center).marginLeft(6)

        badgeIcon.pin.sizeToFit().below(of: linkIconLeft,aligned: .left).marginTop(8)
        badgeNum.pin.sizeToFit().below(of: linkVector, aligned: .center).marginTop(15)
        joinDate.pin.sizeToFit().right(of: badgeIcon, aligned: .center).marginLeft(8)

        followingNum.pin.sizeToFit().below(of: badgeIcon, aligned: .left).marginTop(8)
        followerNum.pin.sizeToFit().right(of: followingNum, aligned: .bottom).marginLeft(10)
        //编辑个人紫椒
        editProfileButton.pin.right(of: followerNum, aligned: .bottom
        ).height(25).width(103).marginLeft(64)
                                                    
        //oCardView
        oCardView.pin.sizeToFit().wrapContent().below(of: followingNum,aligned: .left).marginTop(20).right(15)
        oCardRectangle.pin.width(345).height(100)
        oCardTitle.pin.sizeToFit().top(12).left(15)
        availableLabel.pin.sizeToFit().left(243).top(22)
        available.pin.sizeToFit().right(of: availableLabel, aligned: .center)
        priceLabel.pin.sizeToFit().below(of: oCardTitle,aligned: .left).marginTop(10)
        price.pin.sizeToFit().below(of:available, aligned: .right).marginTop(10)
        manageButton.pin.sizeToFit().below(of: priceLabel, aligned: .left).marginLeft(-15).marginTop(10)
        mintButton.pin.sizeToFit().right(of:manageButton , aligned: .center)

        //ballanceCardView布局
        balanceCardView.pin.sizeToFit().wrapContent().below(of: manageButton, aligned: .left).marginTop(10).right(15)
        balanceCardRectangle.pin.height(75).width(345)
        balanceLabel.pin.sizeToFit().top(11).left(15)
        balance.pin.sizeToFit().right(of: balanceLabel, aligned: .center).marginLeft(12)
        depositButton.pin.sizeToFit().below(of: balanceLabel, aligned:.center).marginTop(10.5)
        withdrawButton.pin.sizeToFit().right(of: depositButton, aligned: .bottom)

        // 附加提示空投
        additionInfo.pin.sizeToFit().below(of: balanceCardRectangle , aligned: .center).marginTop(5)
        
    }
}
