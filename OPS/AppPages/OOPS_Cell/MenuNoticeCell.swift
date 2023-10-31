//
// Created by Aaron on 5/9/21.
//

import PinLayout
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct MenuNoticeCell_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ViewPreview {
                let a = MenuNoticeCell()
                return a
            }
        }
    }
}
#endif

class MenuNoticeCell: UITableViewCell {
    let selectionImageView = UIImageView(image: #imageLiteral(resourceName: "Ellipse 93"))
    let contentLabel = UILabel()
    private let padding:CGFloat = 8

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(selectionImageView)
        contentView.addSubview(contentLabel)

        contentLabel.font = MyThemes.fontWithLanguage(size: 14)
        contentLabel.theme_textColor = MyThemes.textInputBackgroundColor
        contentLabel.lineBreakMode = .byWordWrapping
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .left
        selectionStyle = .none
        backgroundColor = .clear
    }

    override var isSelected: Bool {
        get {
            super.isSelected
        }
        set {
            super.isSelected = newValue
            UIView.transition(with: selectionImageView, duration: 0.3, options: .transitionCrossDissolve) {
                self.selectionImageView.image = newValue ? #imageLiteral(resourceName: "Group 1334") : #imageLiteral(resourceName: "Ellipse 93")
            }
        }
    }

    func setContent(_ s:String) {
        contentLabel.text = s
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        selectionImageView.pin.sizeToFit().left().vCenter()
        contentLabel.pin.sizeToFit(.width).start(to: selectionImageView.edge.right).end().marginLeft(20).vCenter()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // 1) Set the contentView's width to the specified size parameter
        contentView.pin.width(size.width)

        // 2) Layout the contentView's controls
        layout()

        // 3) Returns a size that contains all controls
        return CGSize(width: contentView.frame.width, height: contentLabel.frame.maxY + padding)
    }
}
