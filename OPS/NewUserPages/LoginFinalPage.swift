//
// Created by Aaron on 4/27/21.
//

import PinLayout
import UIKit
import WalletCore
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct LoginFinalPage_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let vc = LoginFinalPage()
            vc.thePwd = "123123123"
            vc.theSeed = ["tuna", "night", "replace", "noise", "offer", "raccoon", "ordinary", "once", "phone", "warm", "symptom", "collect"]
            vc.created = false
            return UINavigationController(rootViewController: vc)
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif

class LoginFinalPage: NewUserPage {
    let l1 = UILabel()

    let nameField = PaddedTextField()
    let nameLabel = UILabel()

    var created = true
    var thePwd = ""
    var theSeed: [String]?
    var privateKey: PrivateKey!
    override func viewDidLoad() {
        super.viewDidLoad()
        progressImg.image = #imageLiteral(resourceName: "Group 1294-1")
        title = "Set Name"

        l1.text = created ? "Congratulation! You got an Ethereum wallet.\nSet a name and get started." : "Ethereum wallet was imported.\nSet a name and get started."

        l1.theme_textColor = MyThemes.hintCaptionTextColor
        l1.font = MyThemes.fontWithLanguage(size: 12)
        l1.numberOfLines = 0
        l1.textAlignment = .center
        view.addSubview(l1)

        nameField.delegate = self
        nameField.font = MyThemes.fontWithLanguage(size: 14)
        nameField.theme_textColor = MyThemes.textInputColor
        nameField.theme_backgroundColor = MyThemes.textInputBackgroundColor
        nameField.addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
        nameField.layer.cornerRadius = 35 / 2
        nameField.layer.masksToBounds = true
        nameField.textInsets = UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 15)
        view.addSubview(nameField)

        nameLabel.font = MyThemes.fontWithLanguage(size: 14)
        nameLabel.text = "Name"
        nameLabel.theme_textColor = MyThemes.hintCaptionTextColor
        view.addSubview(nameLabel)

        nextButton.setTitle("DONE", for: .normal)
        nextButton.backgroundColor = .gray
        nextButton.isEnabled = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        l1.pin.sizeToFit().below(of: progressImg, aligned: .center).marginTop(15)

        nameField.pin.height(35).below(of: l1).marginTop(20).horizontally(view.pin.layoutMargins).marginHorizontal(15)

        nameLabel.pin.sizeToFit().centerLeft(to: nameField.anchor.centerLeft).marginLeft(10)

        nextButton.pin.height(45).width(of: nameField).below(of: nameField, aligned: .center).marginTop(25)
    }

    @objc func valueDidChange() {
        guard !(nameField.text?.isEmpty ?? true)
        else {
            UIView.animate(withDuration: 0.2) {
                self.nextButton.isEnabled = false
                self.nextButton.backgroundColor = .gray
            }
            return
        }

        UIView.animate(withDuration: 0.2) {
            self.nextButton.isEnabled = true
            self.nextButton.theme_backgroundColor = MyThemes.activeTextColor
        }
    }

    @objc override func nextDidTap(_: UIButton) {
//        WalletController.saveAndReplace(privateKey: privateKey, words: theSeed, pwd: thePwd)
    }
}

extension LoginFinalPage: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn _: NSRange, replacementString str: String) -> Bool {
        if str == "\n" {
            textField.endEditing(true)
            return false
        }
        return true
    }
}
