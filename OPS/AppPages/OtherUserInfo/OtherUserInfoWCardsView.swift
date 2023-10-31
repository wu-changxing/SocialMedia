//
//  OtherUserInfoWCardsView.swift
//  OPS
//
//  Created by Jason on 2021/5/7.
//

import UIKit
import Kingfisher

#if canImport(SwiftUI) && DEBUG
    import SwiftUI
    @available(iOS 13.0, *)
    struct OtherUserInfoWCardsView_Preview: PreviewProvider {
        static var previews: some View {
            ViewPreview {
                let v = OtherUserInfoWCardsView()
                return v
            }
            .previewDevice("iPhone 12")
        }
    }
#endif

class OtherUserInfoWCardsView: UIView {
    
    let thumbImageView = UIImageView()
    let descLabel = UILabel()
    
    let avarilableLabel  = UILabel()
    let avarilableNumLabel  = UILabel()
    
    let priceLabel  = UILabel()
    let priceNumLabel  = UILabel()
    
    let notiButton = UIButton()
    let messageButton = UIButton()
    
    let followLabel = UILabel()
    
    let holdingLabel = UILabel()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDate()
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
    
    func setupView(){
        theme_backgroundColor = MyThemes.basicBackgroundColor
        
        // 图片
        addSubview(thumbImageView)
        thumbImageView.backgroundColor = .gray
        thumbImageView.layer.masksToBounds = true
        thumbImageView.layer.cornerRadius = 20
        
        // 图片上的描述
        addSubview(descLabel)
        descLabel.font = MyThemes.fontWithLanguage(size: 12)
        descLabel.theme_textColor = MyThemes.normalTextColor
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        
        // 可用
        addSubview(avarilableLabel)
        avarilableLabel.font = MyThemes.fontWithLanguage(size: 14)
        avarilableLabel.theme_textColor = MyThemes.normalTextColor
        addSubview(avarilableNumLabel)
        avarilableNumLabel.font = MyThemes.fontWithLanguage(size: 14)
        avarilableNumLabel.theme_textColor = MyThemes.normalTextColor
        
        // 价格
        addSubview(priceLabel)
        priceLabel.font = MyThemes.fontWithLanguage(size: 14)
        priceLabel.theme_textColor = MyThemes.normalTextColor
        addSubview(priceNumLabel)
        priceNumLabel.font = MyThemes.fontWithLanguage(size: 14)
        priceNumLabel.theme_textColor = MyThemes.normalTextColor
        
        // 通知
        addSubview(notiButton)
        notiButton.setImage(#imageLiteral(resourceName: "icon_user_noti"), for: .normal)
        // 消息
        addSubview(messageButton)
        messageButton.setImage(#imageLiteral(resourceName: "icon_user_message"), for: .normal)
        
        // followLabel
        addSubview(followLabel)
        followLabel.theme_textColor = MyThemes.activeTextColor
        followLabel.font = MyThemes.fontWithLanguage(size: 14)
        
        // holding
        addSubview(holdingLabel)
        holdingLabel.theme_textColor = MyThemes.grayTextColor
        holdingLabel.font = MyThemes.fontWithLanguage(size: 14)
    }
    
    func setupLayout(){
        // 图片
        thumbImageView.pin.size(CGSize(width: 180, height: 100)).left(10).top(10)
        // 描述
        descLabel.pin.sizeToFit(.width).width(of:thumbImageView)
            .center(to: thumbImageView.anchor.bottomCenter)
            .marginBottom(20).marginLeft(10).marginRight(10)
        
        // 可用
        avarilableLabel.pin.sizeToFit().left(to: thumbImageView.edge.right).top(10).marginLeft(10)
        avarilableNumLabel.pin.sizeToFit().right(10).top(10)
        
        // 价格
        priceLabel.pin.sizeToFit().topLeft(to: avarilableLabel.anchor.bottomLeft).marginTop(20)
        priceNumLabel.pin.sizeToFit().topRight(to: avarilableNumLabel.anchor.bottomRight).marginTop(20)
        
        // 消息
        messageButton.pin.sizeToFit().bottom(to: thumbImageView.edge.bottom).right(10)
        // 通知
        notiButton.pin.sizeToFit().bottom(to: thumbImageView.edge.bottom).right(to: messageButton.edge.left).marginRight(5)
        
        // follow
        followLabel.pin.sizeToFit().below(of: thumbImageView, aligned: .left).marginTop(10)
        
        // holding
        holdingLabel.pin.sizeToFit().bottom(to: followLabel.edge.bottom).right(10)
        
    }

    
    
    
    func setupDate(){
        let url = URL(string: "https://bing.ioliu.cn/v1/rand?w=800&h=600")
        thumbImageView.kf.setImage(with: url)
        
        descLabel.text = "Every wCard is a unique NFT Tap here to get wCards"
        
        avarilableLabel.text = "AVAILABLE"
        avarilableNumLabel.text = "30"
        
        priceLabel.text = "PRICE"
        priceNumLabel.text = "0.3OPS"
        
        followLabel.text = "Following"
        
        holdingLabel.text = "2 wCards Holding"
    }


}
