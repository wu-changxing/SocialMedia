//
// Created by Aaron on 4/27/21.
//

import PinLayout
import UIKit
import WalletCore
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct ImportPage1_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: ImportPage1())
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif

class ImportPage1: NewUserPage {
    let l1 = UILabel()

    let b1 = UIButton(type: .system)
    let b2 = UIButton(type: .system)
    let b3 = UIButton(type: .system)

    let arrow1 = UIImageView(image: #imageLiteral(resourceName: "Vector 74-1"))
    let arrow2 = UIImageView(image: #imageLiteral(resourceName: "Vector 74-1"))
    let arrow3 = UIImageView(image: #imageLiteral(resourceName: "Vector 74-1"))

    var thePwd = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        progressImg.image = #imageLiteral(resourceName: "Group 1294")
        title = "Import Wallet"

        l1.text = "Choose a method to import your wallet\n⚠️ Support Ethereum only"

        l1.theme_textColor = MyThemes.hintCaptionTextColor
        l1.font = MyThemes.fontWithLanguage(size: 12)
        l1.numberOfLines = 0
        l1.textAlignment = .center
        view.addSubview(l1)

        b1.setTitle("Import Private Key", for: .normal)
        b2.setTitle("Import Keystore", for: .normal)
        b3.setTitle("Import Using Seed Phrase", for: .normal)

        for b in [b1, b2, b3] {
            b.theme_setTitleColor(MyThemes.activeTextColor, forState: .normal)
            b.titleLabel?.font = MyThemes.fontWithLanguage(size: 18, weight: .semibold)
            b.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
            b.titleLabel?.textAlignment = .left
            b.contentHorizontalAlignment = .left
            b.contentVerticalAlignment = .center
            b.backgroundColor = UIColor.white.withAlphaComponent(0.001)
            view.addSubview(b)
        }

        for v in [arrow1, arrow2, arrow3] {
            view.addSubview(v)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        l1.pin.sizeToFit().below(of: progressImg, aligned: .center).marginTop(18)

        arrow1.pin.right(view.pin.layoutMargins).below(of: l1).marginTop(40).marginRight(10)
        arrow2.pin.right(view.pin.layoutMargins).below(of: arrow1).marginTop(40).marginRight(10)
        arrow3.pin.right(view.pin.layoutMargins).below(of: arrow2).marginTop(40).marginRight(10)

        b1.pin.height(50).left(view.pin.layoutMargins).marginLeft(10).right(to: arrow1.edge.left).vCenter(to: arrow1.edge.vCenter)
        b2.pin.height(50).left(view.pin.layoutMargins).marginLeft(10).right(to: arrow2.edge.left).vCenter(to: arrow2.edge.vCenter)
        b3.pin.height(50).left(view.pin.layoutMargins).marginLeft(10).right(to: arrow3.edge.left).vCenter(to: arrow3.edge.vCenter)
    }

    @objc func buttonDidTap(_ sender: UIButton) {
        if sender == b1 {
            // private key
            let vc = ImportPrivateKey()
            vc.thePwd = thePwd
            navigationController?.pushViewController(vc, animated: true)
        }

        if sender == b2 {
            let documentTypes = ["public.content",
                                 "public.data",
                                 "public.text",
                                 "public.source-code"]

            let document = UIDocumentPickerViewController(documentTypes: documentTypes, in: .open)
            document.delegate = self // UIDocumentPickerDelegate
            present(document, animated: true, completion: nil)
            // keystore
        }

        if sender == b3 {
            // seed phrase
            let vc = ImportSeedPhrase()
            vc.thePwd = thePwd
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ImportPage1: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL) {
        controller.dismiss(animated: true) {
            DispatchQueue.global().async {
                guard let d = try? Data(contentsOf: url),
                      let s = StoredKey.importJSON(json: d)
                else {
                    DispatchQueue.main.async {
                        let a = UIAlertController(title: "Failed", message: "Can not read data from this keystore.", preferredStyle: .alert)
                        let c = UIAlertAction(title: "OK", style: .cancel)
                        a.addAction(c)
                        self.navigationController?.present(a, animated: true)
                    }

                    return
                }
                DispatchQueue.main.async {
                    // data get!
                    let vc = ImportKeystore()
                    vc.thePwd = self.thePwd
                    vc.storedKey = s
                    self.navigationController?.present(vc, animated: true)
                }
            }
        }
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
