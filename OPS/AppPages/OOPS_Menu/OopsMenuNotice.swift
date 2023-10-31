//
// Created by Aaron on 5/9/21.
//

import PinLayout
import UIKit


class OopsMenuNotice:UIView {
    enum NoticeType:String {
        case pin, delete, report
    }

    let titleLabel = UILabel()
    let msgLabel = UILabel()
    lazy var tableView: UITableView = {
       let t = UITableView()
        t.delegate = self
        t.dataSource = self
        t.separatorStyle = .none
        t.backgroundColor = .clear
        t.estimatedRowHeight = UITableView.automaticDimension
        t.isScrollEnabled = false
        return t
    }()
    let listOfOptions = [
        "Unwanted commercial content or spam",
        "Pornography or sexually explicit material",
        "Child abuse",
        "Hate speech or graphic violence",
        "Promotes terrorism",
        "Harassment or bullying",
        "Illegal",
    ]
    private var selectedIndex = 0
    let cancelButton = UIButton(type:.system)
    let confirmButton = UIButton(type:.system)

    let line1 = UIView()
    let line2 = UIView()

    var type = NoticeType.pin

    var resultCallback: ((Bool, String) -> ())?

    init(title:String, msg:String = "", type:NoticeType) {
        super.init(frame: .zero)
        theme_backgroundColor = MyThemes.hintCaptionTextColor
        clipsToBounds = true
        layer.cornerRadius = 20

        titleLabel.text = title
        msgLabel.text = msg
        self.type = type

        titleLabel.font = MyThemes.fontWithLanguage(size: 16, weight: .medium)
        titleLabel.theme_textColor = MyThemes.textInputBackgroundColor
        addSubview(titleLabel)

        if type != .report {
            msgLabel.font = MyThemes.fontWithLanguage(size: 14)
            msgLabel.theme_textColor = MyThemes.textInputBackgroundColor
            msgLabel.textAlignment = .left
            msgLabel.lineBreakMode = .byWordWrapping
            msgLabel.numberOfLines = 0
            addSubview(msgLabel)
        } else {
            addSubview(tableView)
            confirmButton.isEnabled = false
        }

        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.theme_setTitleColor(MyThemes.normalTextColor, forState: .normal)
        cancelButton.titleLabel?.font = MyThemes.fontWithLanguage(size: 14)
        cancelButton.addTarget(self, action: #selector(cancelDidTap), for: .touchUpInside)

        confirmButton.setTitle(type.rawValue.capitalized, for: .normal)
        confirmButton.titleLabel?.font = MyThemes.fontWithLanguage(size: 14, weight: .semibold)
        confirmButton.addTarget(self, action: #selector(confirmDidTap), for: .touchUpInside)
        confirmButton.setTitleColor(.gray, for: .disabled)
        if type == .pin {
            confirmButton.theme_setTitleColor(MyThemes.normalTextColor, forState: .normal)
        } else {
            confirmButton.theme_setTitleColor(MyThemes.warningTextColor, forState: .normal)
        }

        addSubview(cancelButton)
        addSubview(confirmButton)

        line1.theme_backgroundColor = MyThemes.basicBackgroundColor
        line2.theme_backgroundColor = MyThemes.basicBackgroundColor
        addSubview(line1)
        addSubview(line2)

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard superview != nil else {return}
        let width:CGFloat = type == .report ? 254 : 325
        frame = CGRect(x: 0, y: 0, width: width, height: 100)

        titleLabel.pin.sizeToFit().top(20).hCenter()
        if type != .report {
            msgLabel.pin.sizeToFit(.width).horizontally(29).below(of: titleLabel).marginTop(14)
            line1.pin.horizontally().height(1).below(of: msgLabel).marginTop(17)
        } else {
            tableView.pin.horizontally(25).below(of: titleLabel).marginTop(14).height(300)
            line1.pin.horizontally().height(1).below(of: tableView).marginTop(17)
        }

        line2.pin.width(1).hCenter().top(to: line1.edge.bottom).height(40)
        cancelButton.pin.height(of: line2).left().right(to: line2.edge.left).below(of: line1)
        confirmButton.pin.size(of: cancelButton).right().below(of: line1)

        pin.width(width).height(line2.frame.maxY).center()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func confirmDidTap() {
        resultCallback?(true, type == .report ? listOfOptions[selectedIndex] : "")
        resultCallback = nil
    }
    @objc func cancelDidTap() {
        resultCallback?(false, "")
        resultCallback = nil
    }
}
extension OopsMenuNotice:UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuNoticeCell()
        cell.setContent(listOfOptions[indexPath.row])
        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))?.isSelected = false
        tableView.cellForRow(at: indexPath)?.isSelected = true
        selectedIndex = indexPath.row
        confirmButton.isEnabled = true
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // The UITableView will call the cell's sizeThatFit() method to compute the height.
        // WANRING: You must also set the UITableView.estimatedRowHeight for this to work.
        UITableView.automaticDimension
    }
}

