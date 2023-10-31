//
// Created by Aaron on 4/27/21.
//

import PinLayout
import UIKit
import WalletCore
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ImportKeystore_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let vc = ImportKeystore()
            let keystore = "{\"activeAccounts\":[{\"address\":\"0xebD743486083Dc6a786E9CC96015f523930B93Cc\",\"coin\":60,\"derivationPath\":\"m/44\'/60\'/0\'/0/0\"}],\"crypto\":{\"cipher\":\"aes-128-ctr\",\"cipherparams\":{\"iv\":\"5e8bfebe831587140630747d7ffe77f1\"},\"ciphertext\":\"73e2c2e71484b9fa83948271ddbbfaced01357aa126148445d1717dc4eb1fa5c\",\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,\"n\":4096,\"p\":6,\"r\":8,\"salt\":\"45f597888f3aa36b316c6d199dac1b3e74f4a6ec458953513f21a843d6bd0f72\"},\"mac\":\"13c66369d290f810d1e9c50921394a7577628867c5e78049b19ab0f83bc00260\"},\"id\":\"8020ef9a-8098-4621-b6a5-073c45de4ed1\",\"name\":\"whoops wallet\",\"type\":\"private-key\",\"version\":3}".data(using: .utf8)

            vc.storedKey = StoredKey.importJSON(json: keystore!)

            return UINavigationController(rootViewController: vc)
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif

class ImportKeystore: NewUserPage {
    let l1 = UILabel()
    let l2 = UILabel()
    let pwdField = PaddedTextField()

    var wrongPwd = true
    var storedKey: StoredKey!
    var thePwd = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        progressImg.image = #imageLiteral(resourceName: "Group 1294 (3)")
        title = "Enter Password"

        l1.text = "Enter your keystore password"

        l1.theme_textColor = MyThemes.hintCaptionTextColor
        l1.font = MyThemes.fontWithLanguage(size: 12)
        l1.numberOfLines = 0
        l1.textAlignment = .center
        view.addSubview(l1)

        l2.text = "Password is not correct, try another one."

        l2.theme_textColor = MyThemes.warningTextColor
        l2.font = MyThemes.fontWithLanguage(size: 12)
        l2.numberOfLines = 0
        l2.textAlignment = .center
        l2.alpha = 0
        view.addSubview(l2)

        pwdField.addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
        pwdField.isSecureTextEntry = true
        pwdField.theme_textColor = MyThemes.textInputColor
        pwdField.theme_backgroundColor = MyThemes.textInputBackgroundColor
        pwdField.autocapitalizationType = .none
        pwdField.layer.cornerRadius = 35 / 2
        pwdField.layer.masksToBounds = true
        pwdField.textInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.addSubview(pwdField)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        l1.pin.sizeToFit().below(of: progressImg, aligned: .center).marginTop(18)

        l2.pin.sizeToFit().center(to: l1.anchor.center)

        pwdField.pin.height(35).below(of: l1).marginTop(20).horizontally(view.pin.layoutMargins).marginHorizontal(15)

        nextButton.pin.height(45).width(of: pwdField).below(of: pwdField, aligned: .center).marginTop(25)
    }

    @objc override func nextDidTap(_ sender: UIButton) {
        let pwd = pwdField.text ?? ""

        guard let privateKey = storedKey.privateKey(coin: .ethereum, password: pwd.data(using: .utf8)!) else {
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
        vc.created = false
        vc.privateKey = privateKey
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
