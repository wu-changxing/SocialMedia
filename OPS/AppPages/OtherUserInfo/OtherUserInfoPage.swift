//
//  OtherUserInfoPageViewController.swift
//  OPS
//
//  Created by Jason on 2021/5/6.
//

import PinLayout
import UIKit
import YNPageViewController

#if canImport(SwiftUI) && DEBUG
    import SwiftUI
    @available(iOS 13.0, *)
    struct OtherUserInfoPage_Preview: PreviewProvider {
        static var previews: some View {
            ViewControllerPreview {
                OtherUserInfoPage()
            }
            .previewDevice("iPhone 12")
        }
    }
#endif

class OtherUserInfoPage: ThemedUIViewController {
    let topImageView = UIImageView(image: #imageLiteral(resourceName: "other_user_top_image"))

    let userInfoContainerView = OtherUserInfoTopInfoView()
    
    let wCardsView = OtherUserInfoWCardsView()
    
    let followMeLabel = UILabel()
    
    var containerController: YNPageViewController!
    
    let headerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let navbarView = UIView()
        view.addSubview(navbarView)
        navbarView.pin.height(130).left(0).right(0)
//        navbarView.backgroundColor = UIColor(red: 0.141, green: 0.184, blue: 0.243, alpha: 0.7)
        
        let backBtn = UIButton()
        backBtn.setImage(#imageLiteral(resourceName: "icon_nav_back"), for: .normal)
        navbarView.addSubview(backBtn)
        backBtn.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backBtn.layer.cornerRadius = 15
        backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        
        backBtn.pin.size(CGSize(width: 30, height: 30)).bottom(15).left(15)
        backBtn.addTarget(self, action: #selector(navBackClick), for: .touchUpInside)
        
        let rightButton = UIButton()
        navbarView.addSubview(rightButton)
        rightButton.setImage(#imageLiteral(resourceName: "icon_nav_more"), for: .normal)
        rightButton.addTarget(self, action: #selector(menuDidTap), for: .touchUpInside)
        rightButton.pin.size(CGSize(width: 40, height: 40)).bottom(15).right(10)
    }

    func setupView() {
        let screenWidth = UIScreen.main.bounds.width
        
        view.theme_backgroundColor = MyThemes.cellBackgroundColor
        
        headerView.pin.size(CGSize(width: screenWidth, height: 600))
        
        headerView.addSubview(topImageView)
        topImageView.pin.left(0).right(0).height(180)
        
        headerView.addSubview(userInfoContainerView)
        userInfoContainerView.pin.left(0).right(0).top(140)
        userInfoContainerView.layer.layoutIfNeeded()
        
        headerView.addSubview(wCardsView)
        wCardsView.layer.cornerRadius = 20
        wCardsView.layer.masksToBounds = true
        wCardsView.pin.left(10).right(10).top(userInfoContainerView.frame.maxY + 10).height(150)

        headerView.addSubview(followMeLabel)
        followMeLabel.text = "Get my wCards to follow me. "
        followMeLabel.theme_textColor = MyThemes.grayTextColor
        followMeLabel.font = MyThemes.fontWithLanguage(size: 14)
        
        followMeLabel.pin.sizeToFit().below(of: wCardsView, aligned: .center).marginTop(10)
        
        headerView.pin.height(followMeLabel.frame.maxY + 10)
        
        let titleArr = ["OOP", "LIKES", "MEDIA"]
        
        let configration = YNPageConfigration.defaultConfig()
        configration?.pageStyle = .suspensionCenter
        configration?.scrollViewBackgroundColor = .clear
        configration?.lineHeight = 0
        configration?.scrollMenu = false
        configration?.aligmentModeCenter = false
        configration?.lineWidthEqualFontWidth = false

        configration?.selectedItemColor = UIColor(red: 0.204, green: 0.471, blue: 0.965, alpha: 1)
        configration?.normalItemColor = UIColor(red: 0.286, green: 0.42, blue: 0.573, alpha: 1)
        
        configration?.itemFont = MyThemes.fontWithLanguage(size: 14)
        configration?.selectedItemFont = MyThemes.fontWithLanguage(size: 14)
    
        configration?.bottomLineHeight = 1
        configration?.bottomLineBgColor = .gray
                
        containerController = YNPageViewController(controllers: [
            OtherUserInfoOopViewController(),
            OtherUserInfoLikesViewController(),
            OtherUserInfoMediaViewController(),
        ], titles: titleArr, config: configration)
        containerController?.dataSource = self
        containerController?.delegate = self
        
        containerController?.headerView = headerView
        
        containerController?.view.theme_backgroundColor = MyThemes.cellBackgroundColor
    
        containerController.view.pin.left(0).right(0).bottom(0)
        addChild(containerController!)
    
        view.addSubview(containerController!.view)
        
        // ocar跳转
        let ges = UITapGestureRecognizer(target: self, action: #selector(oCardsDidTap))
        wCardsView.addGestureRecognizer(ges)
    }
    
    @objc func oCardsDidTap() {
        let vc = OtherUserInfoOCardsPage()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func menuDidTap(_ sender: UIButton) {
        OopsMenu(with: "ooper", with: "").show(onViewController: self, near: sender).userDidActionCallback {
            print($0, $1)
        }
    }
    
    @objc func navBackClick() {
        navigationController?.popViewController(animated: true)
    }
}

extension OtherUserInfoPage: YNPageViewControllerDelegate, YNPageViewControllerDataSource {
    func pageViewController(_ pageViewController: YNPageViewController!, pageFor index: Int) -> UIScrollView! {
        let vc = pageViewController.controllersM()[index]
        if index == 0 {
            let controller = vc as! OtherUserInfoOopViewController
            return controller.tableView
        }
        if index == 1 {
            let controller = vc as! OtherUserInfoLikesViewController
            return controller.tableView
        }
        
        if index == 2 {
            let controller = vc as! OtherUserInfoMediaViewController
            return controller.collectionView
        }
        let controller = vc as! FeedPage
        return controller.feedTableView
    }
}
