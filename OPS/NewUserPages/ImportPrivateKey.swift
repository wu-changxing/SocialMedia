//
// Created by Aaron on 4/27/21.
//

import PinLayout
import UIKit
import WalletCore
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ImportPrivateKey_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: ImportPrivateKey())
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif

class ImportPrivateKey: NewUserPage {
    let l1 = UILabel()
    let l2 = UILabel()
    let pwdField = UITextView()

    var thePwd = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        progressImg.image = #imageLiteral(resourceName: "Group 1294 (3)")
        title = "Import Private Key"

        l1.text = "Enter your private key"

        l1.theme_textColor = MyThemes.hintCaptionTextColor
        l1.font = MyThemes.fontWithLanguage(size: 12)
        l1.numberOfLines = 0
        l1.textAlignment = .center
        view.addSubview(l1)

        l2.text = "Private key inputted is not correct"

        l2.theme_textColor = MyThemes.warningTextColor
        l2.font = MyThemes.fontWithLanguage(size: 12)
        l2.numberOfLines = 0
        l2.textAlignment = .center
        l2.alpha = 0
        view.addSubview(l2)

        pwdField.delegate = self
        pwdField.theme_textColor = MyThemes.textInputColor
        pwdField.theme_backgroundColor = MyThemes.textInputBackgroundColor
        pwdField.autocapitalizationType = .none
        pwdField.layer.cornerRadius = 20
        pwdField.layer.masksToBounds = true
        pwdField.font = MyThemes.fontWithLanguage(size: 14)
        pwdField.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)

        view.addSubview(pwdField)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        l1.pin.sizeToFit().below(of: progressImg, aligned: .center).marginTop(18)

        l2.pin.sizeToFit().center(to: l1.anchor.center)

        pwdField.pin.height(80).below(of: l1).marginTop(20).horizontally(view.pin.layoutMargins).marginHorizontal(15)

        nextButton.pin.height(45).width(of: pwdField).below(of: pwdField, aligned: .center).marginTop(25)
    }

    @objc override func nextDidTap(_ sender: UIButton) {
        let pk = pwdField.text ?? ""

        guard pk.range(of: "^(0x)?[a-zA-Z0-9]{64}$", options: .regularExpression) != nil,
              let data = Data(hexString: pk),
              let privateKey = PrivateKey(data: data)
        else {
            UIView.animateSpring {
                self.l1.alpha = 0
                self.l2.alpha = 1
                self.nextButton.theme_backgroundColor = MyThemes.warningTextColor
                self.nextButton.isEnabled = false
                self.nextButton.setTitle(nil, for: .normal)
                self.nextButton.setImage(#imageLiteral(resourceName: "Group"), for: .normal)
            }
            return
        }

        let vc = LoginFinalPage()
        vc.thePwd = thePwd
        vc.privateKey = privateKey
        vc.created = false
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func valueDidChange() {
        l1.alpha = 1
        l2.alpha = 0
        UIView.animateSpring {
            self.nextButton.theme_backgroundColor = MyThemes.activeTextColor
            self.nextButton.isEnabled = true
            self.nextButton.setTitle("NEXT", for: .normal)
            self.nextButton.setImage(nil, for: .normal)
        }
    }
}

extension ImportPrivateKey: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        valueDidChange()
    }
}
