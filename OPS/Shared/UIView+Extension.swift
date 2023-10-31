//
// Created by Aaron on 4/27/21.
//

import UIKit

extension UIView {
    static func animateSpring(withDuration: TimeInterval = 0.3, animations: @escaping () -> Void, completion: @escaping (Bool) -> Void = { _ in }) {
        UIView.animate(withDuration: withDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.allowUserInteraction, .beginFromCurrentState], animations: animations, completion: completion)
    }
}

extension UIView {
    func animateBorder(toValue: CGFloat, duration: Double) {
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.fromValue = layer.borderWidth
        animation.toValue = toValue
        animation.duration = duration
        
        layer.add(animation, forKey: "Width")
        layer.borderWidth = toValue
        
    }
}
