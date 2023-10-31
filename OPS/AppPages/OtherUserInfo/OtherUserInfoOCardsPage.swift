//
//  OtherUserInfoOCardsPage.swift
//  OPS
//
//  Created by Jason on 2021/5/10.
//

import UIKit
#if canImport(SwiftUI) && DEBUG
    import SwiftUI
    @available(iOS 13.0, *)
    struct OtherUserInfoOCardsPage_Preview: PreviewProvider {
        static var previews: some View {
            ViewControllerPreview {
                OtherUserInfoOCardsPage()
            }
            .previewDevice("iPhone 12")
        }
    }
#endif

class OtherUserInfoOCardsPage: UIViewController {
    let tableView = UITableView()
    
    let topImageView = UIImageView(image: #imageLiteral(resourceName: "other_user_top_image"))
    
    let userView = UIView()
    let avatarImageView = UIImageView(image: #imageLiteral(resourceName: "photo"))
    let nameLabel = UILabel()
    let atLabel = UILabel()
    let followYouLabel = UILabel()
    
    let purchaseBtn = UIButton()
    
    let topInfoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidesBottomBarWhenPushed = true
        view.theme_backgroundColor = MyThemes.cellBackgroundColor
        
        setupView()
        setContent()
        
        // 导航
        setupNav()
    }
    
    func setupView() {
        view.addSubview(topImageView)
        
        view.addSubview(userView)
        userView.addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 40.0
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.masksToBounds = true
        
        userView.addSubview(nameLabel)
        nameLabel.theme_textColor = MyThemes.normalTextColor
        nameLabel.font = MyThemes.fontWithLanguage(size: 20)
        
        userView.addSubview(atLabel)
        atLabel.theme_textColor = MyThemes.grayTextColor
        atLabel.font = MyThemes.fontWithLanguage(size: 12)
        
        userView.addSubview(followYouLabel)
        followYouLabel.theme_textColor = MyThemes.normalTextColor
        followYouLabel.theme_backgroundColor = MyThemes.hintCaptionTextColor
        followYouLabel.font = MyThemes.fontWithLanguage(size: 10)
        followYouLabel.layer.cornerRadius = 7
        followYouLabel.textAlignment = .center
        followYouLabel.layer.masksToBounds = true
        
        // 购买按钮
        view.addSubview(purchaseBtn)
        purchaseBtn.setTitle("PURCHASE", for: .normal)
        purchaseBtn.layer.cornerRadius = 20
        
        // label
        view.addSubview(topInfoLabel)
        topInfoLabel.font = MyThemes.fontWithLanguage(size: 16)
        topInfoLabel.theme_textColor = MyThemes.grayTextColor
        topInfoLabel.numberOfLines = 0
        topInfoLabel.textAlignment = .center
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 130
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        
        tableView.register(OtherUserOCardsCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    func layout() {
        topImageView.pin.left(0).right(0).height(180)
        
        userView.pin.left(0).right(15).top(140).height(100)
        avatarImageView.pin.size(CGSize(width: 80, height: 80)).left(15)
        nameLabel.pin.sizeToFit().right(of: avatarImageView).marginLeft(10).top(to: avatarImageView.edge.vCenter)
        atLabel.pin.sizeToFit().topLeft(to: nameLabel.anchor.bottomLeft)
        followYouLabel.pin.centerLeft(to: atLabel.anchor.centerRight).marginLeft(5).height(14).width(66)
        // lable
        topInfoLabel.pin.sizeToFit(.width).below(of: followYouLabel).right(0).left(0).marginTop(20)
                
        // purchaseBtn
        purchaseBtn.pin.left(55).right(55).bottom(40).height(50)
        purchaseBtn.theme_backgroundColor = MyThemes.activeTextColor
        
        // tableveiw
        tableView.pin.left(0).right(0).top(to: topInfoLabel.edge.bottom).marginTop(20).bottom(100)
    }
    
    private func setupNav() {
        let navbarView = UIView()
        view.addSubview(navbarView)
        navbarView.pin.height(130).left(0).right(0)

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
        
        // title
        let titleLabel = UILabel()
        titleLabel.text = "OCards"
        titleLabel.font = MyThemes.fontWithLanguage(size: 60)
        titleLabel.theme_textColor = MyThemes.normalTextColor
        navbarView.addSubview(titleLabel)
        titleLabel.pin.sizeToFit().center(to: navbarView.anchor.bottomCenter).marginBottom(40)
    }
    
    override func viewDidLayoutSubviews() {
        layout()
    }
    
    func setContent() {
        let url = URL(string: "https://pic1.zhimg.com/v2-62f4cd5164f3ad1b75405afb6fa9e379_720w.jpg?source=172ae18b")
        avatarImageView.kf.setImage(with: url)

        nameLabel.text = "PaRCT 85"

        atLabel.text = "@RCT_85"

        followYouLabel.text = "Follows you"
        
        topInfoLabel.text = "Choose your favorite OCards\nPrice:  0,999,999.3333 OPS Points / OCard"
    }
    
    @objc func navBackClick() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func menuDidTap(_ sender: UIButton) {
        OopsMenu(with: "ooper", with: "").show(onViewController: self, near: sender).userDidActionCallback {
            print($0, $1)
        }
    }
}

extension OtherUserInfoOCardsPage: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OtherUserOCardsCell
        return cell
    }
}
