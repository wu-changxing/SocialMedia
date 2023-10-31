//
//  OtherUserMediaCell.swift
//  OPS
//
//  Created by Jason on 2021/5/10.
//

import UIKit

class OtherUserMediaCell: UICollectionViewCell {
    let imageView = UIImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 14
        imageView.layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    
    private func layout() {
        
        imageView.pin.left(0).top(0).right(0).bottom(0)
        
    }
    
    func setContent( url:String) {
        let url = URL(string:url)
        imageView.kf.setImage(with: url)
    }
    
}
