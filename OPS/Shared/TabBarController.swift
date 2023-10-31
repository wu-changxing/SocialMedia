//
// Created by Aaron on 4/28/21.
//

import UIKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct TabBarController_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let vc = TabBarController()
//            vc.viewControllers = [FeedPage(),FeedPage(),FeedPage(),FeedPage(),FeedPage()]
            return vc
        }
    }
}
#endif

class TabBarController: ThemedUIViewController {
    private var lastContentOffset: CGFloat = 0

    var selectedIndex: Int = 0
    var previousIndex: Int = 0

    var viewControllers: [UIViewController] = [
        UINavigationController(rootViewController: FeedPage()),
        UINavigationController(rootViewController: FeedPage()),
        UINavigationController(),
        UINavigationController(rootViewController: FeedPage()),
        UINavigationController(rootViewController: FeedPage())
    ]

    let headButton = UIButton()
    let homeButton = UIButton()
    let whoopButton = UIButton()
    let noticeButton = UIButton()
    let broadcastButton = UIButton()

    var buttons: [UIButton] = []
    var tabView = UIView()
    var footerHeight: CGFloat = 50

    var isTabBarHidden = false {
        didSet {
            UIView.animateSpring {
                self.viewDidLayoutSubviews()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headButton.tag = 0

        headButton.setImage(#imageLiteral(resourceName: "photo"), for: .normal)
        headButton.layer.cornerRadius = 20
        headButton.layer.masksToBounds = true
        headButton.layer.theme_borderColor = MyThemes.activeTextCGColor
        headButton.layer.borderWidth = 0

        homeButton.theme_tintColor = MyThemes.hintCaptionTextColor
        homeButton.setImage(#imageLiteral(resourceName: "Group 2"), for: .normal)
        homeButton.tag = 1

        whoopButton.setImage(#imageLiteral(resourceName: "Group 4"), for: .normal)
        whoopButton.tag = 2
        noticeButton.theme_tintColor = MyThemes.hintCaptionTextColor
        noticeButton.setImage(#imageLiteral(resourceName: "Group 1288"), for: .normal)
        noticeButton.tag = 3
        broadcastButton.theme_tintColor = MyThemes.hintCaptionTextColor
        broadcastButton.setImage(#imageLiteral(resourceName: "Group 5"), for: .normal)
        broadcastButton.tag = 4

        buttons = [headButton, homeButton, whoopButton, noticeButton, broadcastButton]

        for b in buttons {
            if b == whoopButton {
                b.addTarget(self, action: #selector(oopButtonTaped), for: .touchUpInside)
            } else {
                b.addTarget(self, action: #selector(tabChanged), for: .touchUpInside)
            }
            b.adjustsImageWhenHighlighted = false
            tabView.addSubview(b)
        }

        tabView.layer.theme_backgroundColor = MyThemes.basicBackgroundCGColor
        tabView.layer.cornerRadius = 25
        if #available(iOS 13.0, *) {
            tabView.layer.cornerCurve = .continuous
        } else {
            // Fallback on earlier versions
        }
        tabView.layer.theme_shadowColor = MyThemes.footerViewShadowCGColor
        tabView.layer.shadowOpacity = 1
        tabView.layer.shadowRadius = 10
        tabView.layer.shadowOffset = .zero
        view.addSubview(tabView)

        tabChanged(buttons[1])
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if isTabBarHidden {
            tabView.pin.height(50).width(285).bottom().marginBottom(-100).hCenter()
        } else {
            tabView.pin.height(50).width(285).bottom(view.pin.safeArea).marginBottom(16).hCenter()
        }

        headButton.pin.height(40).width(40).vCenter().left(5)
        broadcastButton.pin.height(50).width(50).vCenter().right()
        whoopButton.pin.height(50).width(50).center().marginBottom(5)
        let offset = (whoopButton.frame.minX - headButton.frame.midX)/2 - 30
        homeButton.pin.height(50).width(50).vCenter().right(of: headButton).marginLeft(offset)

        let offset1 = (broadcastButton.frame.minX - whoopButton.frame.midX)/2 - 35
        noticeButton.pin.height(50).width(50).vCenter().left(of: broadcastButton).marginRight(offset1)
    }

    func buttonUnselect(_ b: UIButton) {
        if b.tag == 0 {
            b.animateBorder(toValue: 0, duration: 0.2)
        } else if b == whoopButton {
            // do nothing
        } else {
            UIView.animate(withDuration: 0.2) { () -> () in
                b.theme_tintColor = MyThemes.hintCaptionTextColor
            }
        }
    }

    func buttonSelect(_ b: UIButton) {
        if b.tag == 0 {
            b.animateBorder(toValue: 2, duration: 0.2)
        } else if b == whoopButton {
            // do nothing
        } else {
            UIView.animate(withDuration: 0.2) { () -> () in
                b.theme_tintColor = MyThemes.activeTextColor
            }
        }
    }
}

// MARK: - Actions

extension TabBarController {
    @objc func tabChanged(_ sender: UIButton) {
        previousIndex = selectedIndex
        selectedIndex = sender.tag

        guard previousIndex != selectedIndex else {
            let nv = viewControllers[previousIndex] as? UINavigationController
            nv?.popToRootViewController(animated: true)
            return
        }
        buttonUnselect(buttons[previousIndex])
        buttonSelect(sender)

        let previousVC = viewControllers[previousIndex]

        previousVC.willMove(toParent: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParent()

        sender.isSelected = true

        let vc = viewControllers[selectedIndex]
        vc.view.frame = view.frame
        vc.didMove(toParent: self)
        (vc as! UINavigationController).delegate = self
        addChild(vc)
        view.addSubview(vc.view)

        view.bringSubviewToFront(tabView)
    }

    @objc func oopButtonTaped() {
        present(OopPage(), animated: true, completion: nil)
    }
}

extension TabBarController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        (viewController as? ThemedUIViewController)?.tabBarController_OPS = self
        isTabBarHidden = viewController.hidesBottomBarWhenPushed
    }
}

extension TabBarController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        guard currentOffset > 0 else {return}
        if currentOffset > lastContentOffset {
            if !isTabBarHidden {
                isTabBarHidden = true
            }
            // Downward
        } else {
            // Upward
            if isTabBarHidden {
                isTabBarHidden = false
            }
        }
        lastContentOffset = currentOffset
    }
}
