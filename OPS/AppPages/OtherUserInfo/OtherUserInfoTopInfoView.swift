//
//  OtherUserInfoTopInfoView.swift
//  OPS
//
//  Created by Jason on 2021/5/6.
//

import Kingfisher
import UIKit
#if canImport(SwiftUI) && DEBUG
    import SwiftUI
    @available(iOS 13.0, *)
    struct OtherUserInfoTopInfoView_Preview: PreviewProvider {
        static var previews: some View {
            ViewPreview {
                let v = OtherUserInfoTopInfoView()
                v.theme_backgroundColor = MyThemes.basicBackgroundColor
                return v
            }
            .previewDevice("iPhone 12")
        }
    }
#endif
class OtherUserInfoTopInfoView: UIView {
    let avatarImageView = UIImageView(image: #imageLiteral(resourceName: "photo"))
    let nameLabel = UILabel()
    let atLabel = UILabel()
    let followYouLabel = UILabel()
    let userDescLabel = UILabel()

    let linkIconImageView = UIImageView(image: #imageLiteral(resourceName: "icon_user_link"))
    let linkLabel = UILabel()

    let joinedIconImageView = UIImageView(image: #imageLiteral(resourceName: "icon_user_join_date"))
    let joinedLabel = UILabel()
    let followsLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setContent()
        setupView()
    }

    convenience init() {
        self.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        superview?.layoutSubviews()
        setupLayout()
    }

    func setupView() {
        addSubview(avatarImageView)
        avatarImageView.layer.cornerRadius = 40.0
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.masksToBounds = true
        avatarImageView.pin.size(CGSize(width: 80, height: 80)).left(15)

        addSubview(nameLabel)
        nameLabel.theme_textColor = MyThemes.normalTextColor
        nameLabel.font = MyThemes.fontWithLanguage(size: 20)
        nameLabel.pin.sizeToFit().right(of: avatarImageView).marginLeft(10).top(to: avatarImageView.edge.vCenter)

        addSubview(atLabel)
        atLabel.theme_textColor = MyThemes.grayTextColor
        atLabel.font = MyThemes.fontWithLanguage(size: 12)
        atLabel.pin.sizeToFit().topLeft(to: nameLabel.anchor.bottomLeft)

        addSubview(followYouLabel)
        followYouLabel.theme_textColor = MyThemes.normalTextColor
        followYouLabel.theme_backgroundColor = MyThemes.hintCaptionTextColor
        followYouLabel.font = MyThemes.fontWithLanguage(size: 10)
        followYouLabel.layer.cornerRadius = 7
        followYouLabel.textAlignment = .center
//        followYouLabel.layer.borderWidth = 3
//        followYouLabel.layer.borderColor = UIColor(red: 0.286, green: 0.42, blue: 0.573, alpha: 1).cgColor
        followYouLabel.layer.masksToBounds = true

        followYouLabel.pin.centerLeft(to: atLabel.anchor.centerRight).marginLeft(5).height(14).width(66)

        addSubview(userDescLabel)
        userDescLabel.theme_textColor = MyThemes.normalTextColor
        userDescLabel.numberOfLines = 0

        // 链接图标的内容
        addSubview(linkIconImageView)
        addSubview(linkLabel)
        linkLabel.theme_textColor = MyThemes.grayTextColor
        linkLabel.font = MyThemes.fontWithLanguage(size: 12)

        // 加入图标和内容
        addSubview(joinedIconImageView)
        addSubview(joinedLabel)
        joinedLabel.theme_textColor = MyThemes.grayTextColor
        joinedLabel.font = MyThemes.fontWithLanguage(size: 10)

        addSubview(followsLabel)
        followsLabel.theme_textColor = MyThemes.grayTextColor
        followsLabel.font = MyThemes.fontWithLanguage(size: 10)
    }

    func setupLayout() {
        let margin: CGFloat = 15.0
        userDescLabel.pin.sizeToFit(.width).top(100).left(margin).horizontally(10)

        // link
        linkIconImageView.pin.below(of: userDescLabel).marginTop(20).left(margin)
        linkLabel.pin.sizeToFit().after(of: linkIconImageView, aligned: .center).marginLeft(6)
        // join
        joinedIconImageView.pin.below(of: linkLabel).marginTop(2).left(margin)
        joinedLabel.pin.sizeToFit().after(of: joinedIconImageView, aligned: .center).marginLeft(6)
        // follows
        followsLabel.pin.sizeToFit().below(of: joinedLabel).marginTop(5).left(margin)

        frame.size.height = followsLabel.frame.maxY
    }

    func setContent() {
        let url = URL(string: "https://pic1.zhimg.com/v2-62f4cd5164f3ad1b75405afb6fa9e379_720w.jpg?source=172ae18b")
        avatarImageView.kf.setImage(with: url)

        nameLabel.text = "PaRCT 85"

        atLabel.text = "@RCT_85"

        followYouLabel.text = "Follows you"

        userDescLabel.text = "Frontend developer during daylight, game developer during the night. Currently working on Night of the ritual - an horror slasher point and click adventure....................."

        linkLabel.text = "rarible.com/raminnasibov"

        joinedLabel.text = "Joined April 2016"

        followsLabel.text = "134,177 Following    13.8K Followers"
    }
}
