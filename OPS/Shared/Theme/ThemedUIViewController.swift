//
// Created by Aaron on 4/28/21.
//

import UIKit

class ThemedUIViewController: UIViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard
                #available(iOS 13.0, *),
                traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)
                else { return }

        MyThemes.updateTheme(traitCollection)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.theme_backgroundColor = MyThemes.basicBackgroundColor
    }
    
    /// The floating tab bar controller in ops, using this instead of tabBarController.
    weak var tabBarController_OPS: TabBarController?
    
    @available(*, unavailable)
    override var tabBarController: UITabBarController? {get{nil}}
}
