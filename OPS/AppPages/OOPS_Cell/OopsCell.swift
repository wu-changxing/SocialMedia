//
//  OopsCell.swift
//  OPS
//
//  Created by Aaron on 5/6/21.
//

import PinLayout
import UIKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct OopsCell_Preview: PreviewProvider {
    static var previews: some View {
        ViewPreview {
            OopsCell(style: .default, reuseIdentifier: "")
        }
    }
}
#endif

class OopsCell: UITableViewCell {
    let contentLabel = UILabel()
    
    let userHead = UIImageView(image: #imageLiteral(resourceName: "photo"))
    let userName = UILabel()
    let userId = UILabel()
    let menuButton = UIButton(type: .system)
    let timeLabel = UILabel()
    
    let shareButton = UIButton(type: .system)
    let userHeadTapGesture = UITapGestureRecognizer()
    
    private let padding: CGFloat = 10
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        theme_backgroundColor = MyThemes.textInputBackgroundColor
        contentLabel.theme_textColor = MyThemes.normalTextColor
        contentLabel.font = MyThemes.fontWithLanguage(size: 14)
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.numberOfLines = 0
        contentView.addSubview(contentLabel)
        userHead.layer.masksToBounds = true
        userHead.layer.cornerRadius = 22.5
        userHead.contentMode = .scaleAspectFill
        userHead.isUserInteractionEnabled = true
        userHead.addGestureRecognizer(userHeadTapGesture)
        contentView.addSubview(userHead)
        userName.theme_textColor = MyThemes.normalTextColor
        userName.font = MyThemes.fontWithLanguage(size: 14, weight: .semibold)
        userName.textAlignment = .left
        contentView.addSubview(userName)
        userId.theme_textColor = MyThemes.grayTextColor
        userId.font = MyThemes.fontWithLanguage(size: 14)
        userId.textAlignment = .left
        contentView.addSubview(userId)
        
        menuButton.setImage(#imageLiteral(resourceName: "menuButton"), for: .normal)
        contentView.addSubview(menuButton)
        
        timeLabel.theme_textColor = MyThemes.grayTextColor
        timeLabel.font = MyThemes.fontWithLanguage(size: 12, weight: .medium)
        contentView.addSubview(timeLabel)
        
        shareButton.setImage(#imageLiteral(resourceName: "shareButton"), for: .normal)
        contentView.addSubview(shareButton)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layout()
    }
    private func layout() {
        contentLabel.pin.sizeToFit(.width).horizontally(15).top(10)
        shareButton.pin.width(20).height(20).below(of: contentLabel, aligned: .right).marginTop(17).marginRight(20)
        userHead.pin.height(45).width(45).below(of: contentLabel, aligned: .left).marginTop(50)
        userName.pin.sizeToFit().right(of: userHead).bottom(to: userHead.edge.vCenter).marginLeft(10)
        userId.pin.sizeToFit().below(of: userName, aligned: .left)
        menuButton.pin.height(24).width(24).right(to: contentLabel.edge.right).vCenter(to: userName.edge.vCenter)
        timeLabel.pin.sizeToFit().below(of: menuButton, aligned: .right)
        }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
            // 1) Set the contentView's width to the specified size parameter
            contentView.pin.width(size.width)

            // 2) Layout the contentView's controls
            layout()
            
            // 3) Returns a size that contains all controls
            return CGSize(width: contentView.frame.width, height: timeLabel.frame.maxY + padding)
        }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContent(index:Int) {
        shareButton.tag = index
        userHead.tag = index
        
        contentLabel.text = "#IndieGameDev #indieWatch The most anticipated Indie Games for 2021 is a common post title on every other gaming website in January. This is my personal list. Enjoy it This is my personal list. Enjoy it"
        userName.text = "23423SDFRE"
        userId.text = "@adfewcxdgrdv3"
        timeLabel.text = "4d"
    }
    
}
