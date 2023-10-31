//
// Created by Aaron on 4/26/21.
//

import PinLayout
import UIKit
import WalletCore
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct CreatePage2_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            let vc = CreatePage2()
            vc.thePwd = "123123123"
            vc.theSeed = ["tuna", "night", "replace", "noise", "offer", "raccoon", "ordinary", "once", "phone", "warm", "symptom", "collect"]
            return UINavigationController(rootViewController: vc)
        }
        .previewDevice("iPhone SE (2nd generation)")
    }
}
#endif

class CreatePage2: NewUserPage {
    let l1 = UILabel()

    var thePwd = ""
    var theSeed: [String] = []
    var privateKey: PrivateKey!
    var collectionView1: UICollectionView!
    let line = UIView()
    var collectionView2: UICollectionView!

    var userSelectedWords = ["", "", "", "", "", "", "", "", "", "", "", ""]
    var randomizedWords: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Verify Seed Phrase"
        progressImg.image = #imageLiteral(resourceName: "Group 1294 (3)")
        let r = createRandomMan(start: 0, end: 11)
        for _ in 0 ..< theSeed.count {
            randomizedWords.append(theSeed[r()!])
        }

        l1.text = "Please press words in order according to the seed phrase you backuped."
        l1.theme_textColor = MyThemes.hintCaptionTextColor
        l1.font = MyThemes.fontWithLanguage(size: 12)
        l1.numberOfLines = 0
        view.addSubview(l1)

        let layout1 = UICollectionViewFlowLayout()
        layout1.itemSize = CGSize(width: 152 / 2, height: 64 / 2)
        layout1.minimumInteritemSpacing = 10
        layout1.minimumLineSpacing = 10

        let layout2 = UICollectionViewFlowLayout()
        layout2.itemSize = CGSize(width: 152 / 2, height: 64 / 2)
        layout2.minimumInteritemSpacing = 10
        layout2.minimumLineSpacing = 10

        collectionView1 = UICollectionView(frame: .zero, collectionViewLayout: layout1)
        collectionView1.backgroundColor = .clear
        collectionView1.register(Cell1.self, forCellWithReuseIdentifier: "cell1")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        view.addSubview(collectionView1)

        line.theme_backgroundColor = MyThemes.lineColor
        view.addSubview(line)

        collectionView2 = UICollectionView(frame: .zero, collectionViewLayout: layout2)
        collectionView2.backgroundColor = .clear
        collectionView2.register(Cell2.self, forCellWithReuseIdentifier: "cell2")
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView2.allowsMultipleSelection = true
        collectionView2.allowsSelection = true
        view.addSubview(collectionView2)

        nextButton.setTitle("CONFIRM", for: .normal)
        nextButton.backgroundColor = .gray
        nextButton.isEnabled = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        l1.pin.sizeToFit(.width).below(of: progressImg).horizontally(view.pin.layoutMargins).marginHorizontal(25).marginTop(15)

        collectionView1.pin.horizontally(view.pin.layoutMargins).below(of: l1).marginTop(25)

        collectionView1.frame.size.height = collectionView1.collectionViewLayout.collectionViewContentSize.height

        line.pin.height(1).horizontally().below(of: collectionView1).marginTop(20)

        collectionView2.pin.horizontally(view.pin.layoutMargins).below(of: line).marginTop(20)

        collectionView2.frame.size.height = collectionView1.collectionViewLayout.collectionViewContentSize.height

        nextButton.pin.height(45).width(of: collectionView2).below(of: collectionView2, aligned: .center).marginTop(35)
    }

    @objc override func nextDidTap(_: UIButton) {
        let vc = LoginFinalPage()
        vc.thePwd = thePwd
        vc.theSeed = theSeed
        vc.created = true
        vc.privateKey = privateKey
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CreatePage2: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        theSeed.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! Cell1
            cell.setContent(userSelectedWords[indexPath.item], index: indexPath.item + 1)
            return cell
        }
        if collectionView == collectionView2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! Cell2
            cell.setContent(randomizedWords[indexPath.item])
            return cell
        }
        return collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionView1 {
            let w = userSelectedWords[indexPath.item]
            guard let i = randomizedWords.firstIndex(of: w) else { return }
            userSelectedWords[indexPath.item] = ""
            collectionView1.reloadItems(at: [indexPath])
            collectionView2.deselectItem(at: IndexPath(item: i, section: 0), animated: true)
        }

        if collectionView == collectionView2 {
            let w = randomizedWords[indexPath.item]
            let i = userSelectedWords.firstIndex(of: "")!
            userSelectedWords[i] = w
            collectionView1.reloadItems(at: [IndexPath(item: i, section: 0)])
        }

        UIView.animate(withDuration: 0.2) {
            if self.userSelectedWords == self.theSeed {
                self.nextButton.theme_backgroundColor = MyThemes.activeTextColor
                self.nextButton.isEnabled = true
            } else {
                self.nextButton.backgroundColor = UIColor.gray
                self.nextButton.isEnabled = false
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard collectionView == collectionView2 else { return }
        let w = randomizedWords[indexPath.item]
        let i = userSelectedWords.firstIndex(of: w)!
        userSelectedWords[i] = ""
        collectionView1.reloadItems(at: [IndexPath(item: i, section: 0)])
        UIView.animate(withDuration: 0.2) {
            if self.userSelectedWords == self.theSeed {
                self.nextButton.theme_backgroundColor = MyThemes.activeTextColor
                self.nextButton.isEnabled = true
            } else {
                self.nextButton.backgroundColor = UIColor.gray
                self.nextButton.isEnabled = false
            }
        }
    }
}

private class Cell1: UICollectionViewCell {
    let title = UILabel()
    var titleString = ""
    var index = -1
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(title)
        contentView.layer.cornerRadius = 10
        contentView.layer.theme_backgroundColor = MyThemes.cellBackgroundCGColor
        title.theme_textColor = MyThemes.hintCaptionTextColor
        title.font = MyThemes.fontWithLanguage(size: 14, weight: .medium)
        title.textAlignment = .center
        title.minimumScaleFactor = 0.5
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        title.pin.all()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setContent(_ s: String, index: Int) {
        let e = s.isEmpty
        title.text = e ? "\(index)" : s
        contentView.layer.theme_backgroundColor = e ? MyThemes.cellBackgroundCGColor : MyThemes.hintCaptionTextCGColor
        title.theme_textColor = e ? MyThemes.hintCaptionTextColor : MyThemes.cellBackgroundColor
    }
}

private class Cell2: UICollectionViewCell {
    let title = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(title)
        contentView.layer.cornerRadius = 10
        contentView.layer.theme_backgroundColor = MyThemes.hintCaptionTextCGColor
        title.theme_textColor = MyThemes.textSecondaryColor
        title.font = MyThemes.fontWithLanguage(size: 14, weight: .medium)
        title.minimumScaleFactor = 0.5
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

    override var isSelected: Bool {
        get {
            super.isSelected
        }
        set {
            super.isSelected = newValue
            contentView.layer.theme_backgroundColor = newValue ? MyThemes.cellBackgroundCGColor : MyThemes.hintCaptionTextCGColor
            title.alpha = newValue ? 0 : 1
        }
    }
}
