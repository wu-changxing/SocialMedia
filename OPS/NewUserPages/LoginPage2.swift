//
// Created by Aaron on 4/26/21.
//

import PinLayout
import UIKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct LoginPage2_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: LoginPage2())
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif
class LoginPage2: NewUserPage {
    var toCreate = true

    let l1 = UILabel()
    let l2 = UILabel()

    let pwd1 = PaddedTextField()
    let pwd2 = PaddedTextField()
    private var thePwd = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        progressImg.image = #imageLiteral(resourceName: "Group 1293")
        title = "Set Password"

        l1.text = "Enter your pass word ( at least 8 characters )"
        l2.text = "Confirm your pass word"

        for l in [l1, l2] {
            l.theme_textColor = MyThemes.hintCaptionTextColor
            l.font = MyThemes.fontWithLanguage(size: 12)
            view.addSubview(l)
        }

        nextButton.backgroundColor = .gray
        nextButton.isEnabled = false

        settingPwdField(pwd1)
        settingPwdField(pwd2)

        view.addSubview(pwd1)
        view.addSubview(pwd2)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        pwd1.pin.height(35).horizontally(view.layoutMargins).marginHorizontal(15).below(of: progressImg).marginTop(35)
        pwd2.pin.height(35).horizontally(view.layoutMargins).marginHorizontal(15).below(of: pwd1).marginTop(30)

        l1.pin.sizeToFit().above(of: pwd1, aligned: .left).marginLeft(10).marginBottom(5)
        l2.pin.sizeToFit().above(of: pwd2, aligned: .left).marginLeft(10).marginBottom(5)

        nextButton.pin.height(45).width(of: pwd2).below(of: pwd2, aligned: .center).marginTop(25)
    }

    @objc override func nextDidTap(_: UIButton) {
        if toCreate {
            let vc = CreatePage1()
            vc.thePwd = thePwd
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = ImportPage1()
            vc.thePwd = thePwd
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    private func settingPwdField(_ f: PaddedTextField) {
        f.delegate = self
        f.theme_textColor = MyThemes.textInputColor
        f.theme_backgroundColor = MyThemes.textInputBackgroundColor
        f.autocapitalizationType = .none
        f.addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
        f.layer.cornerRadius = 35 / 2
        f.layer.masksToBounds = true
        f.textInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }

    @objc func valueDidChange() {
        guard pwd1.text!.count >= 8, pwd2.text!.count >= 8,
              pwd1.text == pwd2.text
        else {
            UIView.animate(withDuration: 0.2) {
                self.nextButton.isEnabled = false
                self.nextButton.backgroundColor = .gray
            }

            return
        }

        thePwd = pwd2.text!
        UIView.animate(withDuration: 0.2) {
            self.nextButton.isEnabled = true
            self.nextButton.theme_backgroundColor = MyThemes.activeTextColor
        }
    }
}

extension LoginPage2: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn _: NSRange, replacementString str: String) -> Bool {
        if !textField.isSecureTextEntry {
            textField.isSecureTextEntry = true
        }
        if str == "\n" {
            textField.endEditing(true)
            return false
        }
        return true
    }
}
