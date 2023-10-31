//
// Created by Aaron on 4/25/21.
//

import Foundation
import PinLayout
import UIKit

#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct LoginPage1_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: LoginPage1())
        }
        .previewDevice("iPhone Xʀ")
    }
}
#endif

class LoginPage1: ThemedUIViewController {
    let starImage = UIImageView(image: #imageLiteral(resourceName: "starImage"))
    let titleLabel = UILabel()

    let importButton = UIButton(type: .system)
    let createButton = UIButton(type: .system)

    let captionLabel = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(starImage)

        navigationController?.setNavigationBarHidden(true, animated: false)
        titleLabel.theme_textColor = MyThemes.activeTextColor
        titleLabel.font = UIFont(name: "PaytoneOne-Regular", size: 64)
        titleLabel.text = "OPS"
        view.addSubview(titleLabel)

        importButton.setImage(#imageLiteral(resourceName: "Group 1283"), for: .normal)
        importButton.setTitle("Import Wallet   ", for: .normal)

        createButton.setImage(#imageLiteral(resourceName: "Group 1282"), for: .normal)
        createButton.setTitle("Create Wallet    ", for: .normal)

        for b in [importButton, createButton] {
            b.titleLabel?.font = MyThemes.fontWithLanguage(size: 24, weight: .semibold)
            b.theme_setTitleColor(MyThemes.activeTextColor, forState: .normal)
            b.contentHorizontalAlignment = .left
            b.makeImageRightSide()
            b.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
            view.addSubview(b)
        }

        captionLabel.theme_textColor = MyThemes.hintCaptionTextColor
        captionLabel.font = MyThemes.fontWithLanguage(size: 12)
        captionLabel.text = "Choose a way to start using OPS\nEthereum wallet only"
        captionLabel.textAlignment = .center
        captionLabel.numberOfLines = 2
        view.addSubview(captionLabel)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        starImage.pin.sizeToFit().hCenter().top(view.pin.layoutMargins).marginTop(60).marginRight(8)

        titleLabel.pin.sizeToFit().below(of: starImage).marginTop(-10).hCenter()

        importButton.pin.sizeToFit().below(of: titleLabel, aligned: .center).marginTop(25)
        createButton.pin.size(of: importButton).below(of: importButton, aligned: .right).marginTop(26)

        captionLabel.pin.sizeToFit().below(of: createButton, aligned: .center).marginTop(36)
    }

    @objc func nextStep(_ sender: UIButton) {
        let vc = LoginPage2()
        vc.toCreate = sender == createButton
        navigationController?.pushViewController(vc, animated: true)
    }
}
