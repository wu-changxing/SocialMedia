//
//  UIButton+Extension.swift
//  Whoops
//
//  Created by Aaron on 4/25/21.
//

import UIKit

extension UIButton {
    func makeImageRightSide() {
        semanticContentAttribute = UIApplication.shared
            .userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
    }
}
