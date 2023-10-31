//
//  OopsMenu.swift
//  OPS
//
//  Created by Aaron on 5/8/21.
//

import PinLayout
import UIKit
import UITextView_Placeholder

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct OopsMenu_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ViewPreview {
                OopsMenu(with: "", with: "")
            }
            .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif
enum OopsMenuAction {
    case pinned, unPinned, deleted, muted, unMuted, blocked, unBlocked, reported
}

class OopsMenu: UIView {
    var ooper: String? = ""
    var oop: String? = ""
    private var location: CGPoint = .zero
    private var callbackAction: ((OopsMenuAction, Bool) -> ())?

    private let buttonBackground = UIView()

    private let pinButton = UIButton(type: .system)
    private let deleteButton = UIButton(type: .system)
    private let muteButton = UIButton(type: .system)
    private let blockButton = UIButton(type: .system)
    private let reportButton = UIButton(type: .system)
    private let g = UITapGestureRecognizer(target: self, action: #selector(dismiss))
    /// 创建一个菜单，两个参数只需要传一个，两个都传以 oop 生效
    /// - Parameters:
    ///   - ooper:如果是用户首页菜单，就传这个
    ///   - oop:如果是oop菜单，就传这个
    init(with ooper: String? = "", with oop: String? = "") {
        super.init(frame: .zero)
        if let o = oop {
            self.oop = o
        } else {
            self.ooper = ooper
        }

        isUserInteractionEnabled = true
        backgroundColor = .clear
        addGestureRecognizer(g)
        initButtons()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        addGestureRecognizer(tap)
    }

    private func initButtons() {
        buttonBackground.theme_backgroundColor = MyThemes.basicBackgroundColor
        buttonBackground.clipsToBounds = true
        buttonBackground.layer.cornerRadius = 14
        buttonBackground.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        buttonBackground.layer.shadowOpacity = 1
        buttonBackground.layer.shadowRadius = 8
        buttonBackground.layer.shadowOffset = CGSize(width: 0, height: 0)
        addSubview(buttonBackground)

        func set4other() {
            setButton(muteButton, with: "Mute this ooper", img: #imageLiteral(resourceName: "Group 1309"))
            setButton(blockButton, with: "Block this ooper", img: #imageLiteral(resourceName: "Group 1310"))
            setButton(reportButton, with: "Report this ooper", img: #imageLiteral(resourceName: "Group 1311"))
        }
        func set4me() {
            setButton(pinButton, with: "Pin this oop", img: #imageLiteral(resourceName: "pin"))
            setButton(deleteButton, with: "Delete this oop", img: #imageLiteral(resourceName: "Group 1318"))
        }

        if let o = oop {
            let isMySelf = o == "me"
            isMySelf ? set4me() : set4other()
            return
        }
        if let o = ooper {
            set4other()
            return
        }
    }

    private func setButton(_ b: UIButton, with title: String, img: UIImage) {
        b.setTitle(title, for: .normal)
        b.setImage(img, for: .normal)
        b.titleLabel?.font = MyThemes.fontWithLanguage(size: 14)
        b.theme_setTitleColor(MyThemes.normalTextColor, forState: .normal)
        b.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        b.contentHorizontalAlignment = .left
        b.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        b.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        buttonBackground.addSubview(b)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func layoutInit() {
        pin.all()
        buttonBackground.frame = CGRect(x: location.x, y: location.y, width: 10, height: 10)
        if muteButton.superview != nil { // 说明是 other
            muteButton.pin.height(40).top().horizontally()
            blockButton.pin.size(of: muteButton).below(of: muteButton, aligned: .center)
            reportButton.pin.bottom().height(40).horizontally()
        } else { // 说明是self
            pinButton.pin.height(40).top().horizontally()
            deleteButton.pin.height(40).bottom().horizontally()
        }
    }

    private func layoutReady() {
        if muteButton.superview != nil { // 说明是 other
            let topHeightEnough = location.y > 120+layoutMargins.top+10
            if topHeightEnough {
                buttonBackground.frame = CGRect(x: location.x-200, y: location.y-120, width: 200, height: 120)
            } else {
                buttonBackground.frame = CGRect(x: location.x-200, y: location.y, width: 200, height: 120)
            }
            muteButton.pin.height(40).top().horizontally()
            blockButton.pin.size(of: muteButton).below(of: muteButton, aligned: .center)
            reportButton.pin.size(of: muteButton).below(of: blockButton, aligned: .center)
        } else { // 说明是self
            let topHeightEnough = location.y > 80+layoutMargins.top+10
            if topHeightEnough {
                buttonBackground.frame = CGRect(x: location.x-200, y: location.y-80, width: 200, height: 80)
            } else {
                buttonBackground.frame = CGRect(x: location.x-200, y: location.y, width: 200, height: 80)
            }
            pinButton.pin.height(40).top().horizontally()
            deleteButton.pin.size(of: pinButton).below(of: pinButton, aligned: .center)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// 在某 viewController 下显示本 Menu，该方法可与 userDidActionCallback 链式调用
    /// - Parameters:
    ///   - onViewController:  要显示在某 viewController 中
    ///   - view:  在某 view 附近，通常就是那个菜单按钮
    /// - Returns: 该 menu 本身
    @discardableResult
    func show(onViewController: UIViewController, near view: UIView) -> OopsMenu {
        let v = onViewController.view!
        location = v.convert(view.center, from: view.superview)
        v.addSubview(self)
        layoutInit()
        UIView.animateSpring {
            self.layoutReady()
        }

        return self
    }

    /// 用户操作后的回调通知，目前的设计是在menu中执行具体的按钮功能逻辑，回调仅仅作为操作结束后的通知，
    /// 得到通知的界面仅需要根据回调更新界面即可，业务逻辑已经完成。
    /// 该调用可与 show 方法链式调用
    /// - Parameter callback: 回调闭包, 用户执行的动作以及是否成功
    /// - Returns: 该 menu 本身
    @discardableResult
    func userDidActionCallback(_ callback: @escaping (OopsMenuAction, Bool) -> ()) -> OopsMenu {
        callbackAction = callback
        return self
    }

    @objc func dismiss() {
        UIView.animateSpring(animations: {
            self.layoutInit()
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
    private func show(notice:OopsMenuNotice) {
        g.isEnabled = false
        notice.alpha = 0
        addSubview(notice)
        notice.setNeedsLayout()
        UIView.animate(withDuration: 0.3) {
            notice.alpha = 1
            self.theme_backgroundColor = MyThemes.grayMaskBackgroundColor
        }
        UIView.animateSpring(animations: {
            self.layoutInit()
        }, completion: { _ in

        })
    }
    private func dismissWithNotice(_ notice:OopsMenuNotice) {
        UIView.animate(withDuration: 0.3) {
            notice.alpha = 0
            self.backgroundColor = .clear
        } completion: { _ in
            self.removeFromSuperview()
        }
    }
    @objc func buttonDidTap(_ sender: UIButton) {

        switch sender {
            case pinButton :
                let notice = OopsMenuNotice(title: "Pin this OOP", msg: "This will appear at the top of your homepage and replace any previously pinned OOP. Are you sure?", type: .pin)
                notice.resultCallback = { b, _ in
                    if b {
                        self.doTheWork(.pinned, notice)
                    } else {
                        self.dismissWithNotice(notice)
                    }
                }
                show(notice: notice)

            case deleteButton:
                let notice = OopsMenuNotice(title: "Delete this OOP", msg: "Are you sure want to delete this OOP?", type: .delete)
                notice.resultCallback = { b, _ in
                    if b {
                        self.doTheWork(.deleted, notice)
                    } else {
                        self.dismissWithNotice(notice)
                    }
                }
                show(notice: notice)

            case reportButton:
                let notice = OopsMenuNotice(title: "Report this OOP", msg: "", type: .report)
                notice.resultCallback = { b, _ in
                    if b {
                        self.doTheWork(.reported, notice)
                    } else {
                        self.dismissWithNotice(notice)
                    }
                }
                show(notice: notice)

            default:break
        }


    }

    func doTheWork(_ t:OopsMenuAction, _ notice:OopsMenuNotice) {
        self.callbackAction?(t, true)
        self.callbackAction = nil
        self.dismissWithNotice(notice)
    }
}
