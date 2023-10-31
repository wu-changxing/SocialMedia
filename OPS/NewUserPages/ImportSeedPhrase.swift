//
// Created by Aaron on 4/27/21.
//

import PinLayout
import UIKit
import WalletCore
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ImportSeedPhrase_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: ImportSeedPhrase())
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif

class ImportSeedPhrase: NewUserPage {
    let l1 = UILabel()
    let l2 = UILabel()
    let pwdField = UITextView()

    var thePwd = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        progressImg.image = #imageLiteral(resourceName: "Group 1294 (3)")
        title = "Import Seed Phrase"

        l1.text = "Enter your twelve words seed phrase here to import your wallet."

        l1.theme_textColor = MyThemes.hintCaptionTextColor
        l1.font = MyThemes.fontWithLanguage(size: 12)
        l1.numberOfLines = 0
        l1.textAlignment = .center
        view.addSubview(l1)

        l2.text = "Seed phrase inputted not correct.\nPlease check it and try again."

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

        l1.pin.sizeToFit(.width).below(of: progressImg, aligned: .center).marginTop(18).width(of: progressImg)

        l2.pin.sizeToFit(.width).center(to: l1.anchor.center).width(of: progressImg)

        pwdField.pin.height(80).below(of: l1).marginTop(20).horizontally(view.pin.layoutMargins).marginHorizontal(15)

        nextButton.pin.height(45).width(of: pwdField).below(of: pwdField, aligned: .center).marginTop(25)
    }

    @objc override func nextDidTap(_ sender: UIButton) {
          var str = pwdField.text.replacingOccurrences(of: "\r", with: "")
          str = str.replacingOccurrences(of: "\n", with: "")

          // Use the custom isValidMnemonic method
          guard self.isValidMnemonic(mnemonic: str) else {
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

          // Safely unwrap the HDWallet instance
        let w = HDWallet(mnemonic: str, passphrase: "")

          let vc = LoginFinalPage()
          vc.thePwd = thePwd
          vc.privateKey = w.getKeyForCoin(coin: .ethereum)
          vc.created = false
          navigationController?.pushViewController(vc, animated: true)
      }
    

      // Custom method to validate mnemonic
    private func isValidMnemonic(mnemonic: String) -> Bool {
        let words = mnemonic.split(separator: " ")
        let validWordCounts = [12, 15, 18, 21, 24]

        // Check if the word count is valid
        if !validWordCounts.contains(words.count) {
            return false
        }

        // Load or define a list of valid BIP-39 words
        // This is a placeholder; you need to replace it with the actual list
        let bip39Words: Set<String> = ["word1", "word2", "..."]

        // Check each word
        for word in words {
            if !bip39Words.contains(String(word)) {
                return false
            }
        }

        // Add additional checks here if needed (like checksum)

        return true
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

extension ImportSeedPhrase: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        valueDidChange()
    }
}
