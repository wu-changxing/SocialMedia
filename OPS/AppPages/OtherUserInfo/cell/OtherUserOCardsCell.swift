//
//  OtherUserOCardsCell.swift
//  OPS
//
//  Created by Jason on 2021/5/10.
//

import UIKit

class OtherUserOCardsCell: UITableViewCell {
    let conView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(conView)
    
        conView.layer.cornerRadius = 20
        backgroundColor = .clear
        selectionStyle = .none
        conView.theme_backgroundColor = MyThemes.basicBackgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout() {
        conView.pin.left(15).right(15).bottom(10).top(0)
    }
}
