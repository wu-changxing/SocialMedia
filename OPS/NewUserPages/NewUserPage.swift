//
//  NewUserPage.swift
//  Whoops
//
//  Created by Aaron on 4/27/21.
//

import UIKit

class NewUserPage: ThemedUIViewController {
    let titleLabel = UILabel()
    let backButton = UIButton(type: .system)
    let nvTitleLabel = UILabel()
    let progressImg = UIImageView()
    let nextButton = UIButton(type: .system)

    override var title: String? {
        get {
            nvTitleLabel.text
        }
        set {
            nvTitleLabel.text = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        titleLabel.text = "OPS"
        titleLabel.font = UIFont(name: "PaytoneOne-Regular", size: 64)
        titleLabel.theme_textColor = MyThemes.activeTextColor
        view.addSubview(titleLabel)

        backButton.setImage(#imageLiteral(resourceName: "Vector 74"), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        backButton.contentMode = .center
        backButton.backgroundColor = UIColor.white.withAlphaComponent(0.0001)
        view.addSubview(backButton)

        nvTitleLabel.theme_textColor = MyThemes.activeTextColor
        nvTitleLabel.font = MyThemes.fontWithLanguage(size: 24, weight: .semibold)
        view.addSubview(nvTitleLabel)

        view.addSubview(progressImg)

        nextButton.setTitle("NEXT", for: .normal)
        nextButton.theme_backgroundColor = MyThemes.activeTextColor
        nextButton.titleLabel?.font = MyThemes.fontWithLanguage(size: 18, weight: .semibold)
        nextButton.theme_setTitleColor(MyThemes.normalTextColor, forState: .normal)
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 14
        nextButton.addTarget(self, action: #selector(nextDidTap), for: .touchUpInside)
        view.addSubview(nextButton)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLabel.pin.sizeToFit().top(view.pin.layoutMargins).marginTop(20).hCenter()
        backButton.pin.height(15).width(15).below(of: titleLabel).left(view.pin.layoutMargins).marginTop(30)
        nvTitleLabel.pin.sizeToFit().vCenter(to: backButton.edge.vCenter).hCenter()

        progressImg.pin.sizeToFit().below(of: nvTitleLabel, aligned: .center).marginTop(21)
    }

    @objc func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc func nextDidTap(_ sender: UIButton) {}
}
