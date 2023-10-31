//
// Created by Aaron on 4/26/21.
//

import PinLayout
import UIKit
import WalletCore
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct CreatePage1_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            UINavigationController(rootViewController: CreatePage1())
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif

class CreatePage1: NewUserPage {
    let l1 = UILabel()
    let l2 = UILabel()

    let copyButton = UIButton(type: .system)

    var thePwd = ""
    private var theSeed: [String] = []
    private var privateKey: PrivateKey!
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
         let w = HDWallet(strength: 128, passphrase: "") 
        theSeed = w.mnemonic.components(separatedBy: " ")
        privateKey = w.getKeyForCoin(coin: .ethereum)

        title = "Backup Seed Phrase"
        progressImg.image = #imageLiteral(resourceName: "Group 1294")

        l1.text = "This is your seed phrase. Write it down on a paper and keep it in a safe place. You’ll be asked to re- enter this phrase (in order) on the next step."
        l2.text = """
        Attention:
        •Do not disclose seed phrase to anyone.
        •Once the seed phrase are lose, assets cannot be recovered.
        •Do not back up and save by screenshots or network transmission.
        """

        for l in [l1, l2] {
            l.theme_textColor = MyThemes.hintCaptionTextColor
            l.font = MyThemes.fontWithLanguage(size: 12)
            l.numberOfLines = 0

            view.addSubview(l)
        }

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 76, height: 32)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        nextButton.setTitle("Completed Backup, Verify It", for: .normal)

        copyButton.setTitle("Copy Seed Phrase", for: .normal)
        copyButton.theme_setTitleColor(MyThemes.hintCaptionTextColor, forState: .normal)
        copyButton.addTarget(self, action: #selector(copyDidTap), for: .touchUpInside)
        view.addSubview(copyButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        l1.pin.sizeToFit(.width).below(of: progressImg).horizontally(view.pin.layoutMargins).marginHorizontal(15).marginTop(15)

        collectionView.pin.horizontally(view.pin.layoutMargins).below(of: l1).marginTop(20)

        collectionView.frame.size.height = collectionView.collectionViewLayout.collectionViewContentSize.height

        l2.pin.sizeToFit(.width).horizontally(view.pin.layoutMargins).marginHorizontal(10).below(of: collectionView).marginTop(20)

        nextButton.pin.height(45).width(of: collectionView).below(of: l2, aligned: .center).marginTop(35)

        copyButton.pin.sizeToFit().below(of: nextButton, aligned: .center).marginTop(25)
    }

    @objc override func nextDidTap(_: UIButton) {
        let vc = CreatePage2()
        vc.thePwd = thePwd
        vc.theSeed = theSeed
        vc.privateKey = privateKey
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func copyDidTap() {
        let alert = UIAlertController(title: "Copied", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            UIPasteboard.general.string = self.theSeed.joined(separator: " ")
        }
        alert.addAction(okAction)
        navigationController?.present(alert, animated: true)
    }
}

extension CreatePage1: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        theSeed.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        cell.setContent(theSeed[indexPath.item])
        return cell
    }
}

private class Cell: UICollectionViewCell {
    let title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(title)
        contentView.layer.cornerRadius = 10
        contentView.layer.theme_backgroundColor = MyThemes.hintCaptionTextCGColor
        title.theme_textColor = MyThemes.textSecondaryColor
        title.font = MyThemes.fontWithLanguage(size: 14, weight: .medium)
        title.textAlignment = .center
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        title.pin.all()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setContent(_ s: String) {
        title.text = s
    }
}
