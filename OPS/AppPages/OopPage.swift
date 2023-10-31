//
//  OopPage.swift
//  OPS
//
//  Created by Aaron on 5/2/21.
//

import PinLayout
import UIKit
import UITextView_Placeholder

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct OopPage_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ViewControllerPreview {
                UINavigationController(rootViewController: OopPage())
            }
            .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
#endif

class OopPage: ThemedUIViewController {
    private var textOverLength = false

    let userHead = UIImageView()
    let userName = UILabel()
    let userId = UILabel()

    let cancelButton = UIButton(type: .system)

    let textView = UITextView()

    let oopsButton = UIButton()

    let textLimitLabel = UILabel()
    let textLimitLabel2 = UILabel()

    private var keyboardHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        userHead.image = #imageLiteral(resourceName: "photo")
        userHead.layer.cornerRadius = 20
        userHead.layer.masksToBounds = true

        userName.font = MyThemes.fontWithLanguage(size: 14, weight: .semibold)
        userName.theme_textColor = MyThemes.normalTextColor
        userName.text = "Anonymous"

        userId.font = MyThemes.fontWithLanguage(size: 14)
        userId.theme_textColor = MyThemes.grayTextColor
        userId.text = "@xxxx"

        cancelButton.theme_setTitleColor(MyThemes.activeTextColor, forState: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissPage), for: .touchUpInside)

        textView.theme_backgroundColor = MyThemes.textInputBackgroundColor
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20
        textView.theme_textColor = MyThemes.textInputColor
        textView.font = UIFont(name: "PingFangSC-Medium", size: 14)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.placeholder = "What’s happening?"
        textView.placeholderTextView.theme_textColor = MyThemes.grayTextColor
        textView.placeholderTextView.font = UIFont(name: "PingFangSC-Medium", size: 14)
        textView.delegate = self

        oopsButton.setImage(#imageLiteral(resourceName: "rocket whoop"), for: .normal)
        oopsButton.layer.cornerRadius = 25
        oopsButton.theme_backgroundColor = MyThemes.activeTextColor
        oopsButton.layer.masksToBounds = true
        oopsButton.addTarget(self, action: #selector(sendMsg), for: .touchUpInside)

        view.addSubview(userHead)
        view.addSubview(userName)
        view.addSubview(userId)
        view.addSubview(cancelButton)
        view.addSubview(textView)
        view.addSubview(oopsButton)

        textLimitLabel.font = UIFont(name: "PingFangSC-Medium", size: 12)
        textLimitLabel.theme_textColor = MyThemes.grayTextColor
        textLimitLabel.text = "0"
        textLimitLabel.textAlignment = .right
        view.addSubview(textLimitLabel)

        textLimitLabel2.font = UIFont(name: "PingFangSC-Medium", size: 12)
        textLimitLabel2.theme_textColor = MyThemes.grayTextColor
        textLimitLabel2.text = "/280"
        textLimitLabel2.textAlignment = .right
        view.addSubview(textLimitLabel2)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillUp), name: UIApplication.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidDown), name: UIApplication.keyboardWillHideNotification, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        textView.becomeFirstResponder()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        userHead.pin.height(40).width(40).left(view.pin.layoutMargins).top(view.pin.layoutMargins).marginTop(20)
        userName.pin.sizeToFit().right(of: userHead).marginLeft(10).bottom(to: userHead.edge.vCenter).marginBottom(2)

        userId.pin.sizeToFit().below(of: userName, aligned: .left)

        cancelButton.pin.sizeToFit().right(view.pin.layoutMargins).bottom(to: userHead.edge.bottom)

        oopsButton.pin.height(50).width(50).hCenter().bottom(keyboardHeight).marginBottom(15)

        textView.pin.horizontally(view.pin.layoutMargins).below(of: userHead).marginTop(10).bottom(to: oopsButton.edge.top).marginBottom(13)

        textLimitLabel2.pin.sizeToFit().bottomRight(to: textView.anchor.bottomRight).margin(10)
        textLimitLabel.pin.size(of: textLimitLabel2).left(of: textLimitLabel2, aligned: .center)
    }

    @objc func keyboardWillUp(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        keyboardHeight = keyboardSize.height
        UIView.animate(withDuration: 0.3) { () -> () in
            self.viewDidLayoutSubviews()
        }
    }

    @objc func keyboardDidDown() {
        keyboardHeight = 0
        UIView.animate(withDuration: 0.3) { () -> () in
            self.viewDidLayoutSubviews()
        }
    }

    @objc func sendMsg() {}

    @objc func dismissPage() {
        dismiss(animated: true)
    }
}

extension OopPage: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentLength = textView.text.countOOP
        textLimitLabel.text = "\(currentLength)"

        if textOverLength != (currentLength > 280) {
            textOverLength = currentLength > 280
            UIView.transition(with: textLimitLabel, duration: 0.3, options: .transitionCrossDissolve) {
                if self.textOverLength {
                    self.textLimitLabel.theme_textColor = MyThemes.warningTextColor
                } else {
                    self.textLimitLabel.theme_textColor = MyThemes.grayTextColor
                }
            }
            UIView.transition(with: oopsButton, duration: 0.3, options: .transitionCrossDissolve) {
                if self.textOverLength {
                    self.oopsButton.setImage(#imageLiteral(resourceName: "post an ops"), for: .normal)
                } else {
                    self.oopsButton.setImage(#imageLiteral(resourceName: "rocket whoop"), for: .normal)
                }
            }
        }
    }
}
