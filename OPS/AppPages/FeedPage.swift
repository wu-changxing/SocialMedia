//
// Created by Aaron on 4/28/21.
//

import PinLayout
import UIKit
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13.0, *)
struct FeedPage_Preview: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            FeedPage()
        }
    }
}
#endif

class FeedPage: ThemedUIViewController {
    let feedTableView = UITableView()

    let feeds: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.theme_backgroundColor = MyThemes.textInputBackgroundColor
        feedTableView.theme_backgroundColor = MyThemes.textInputBackgroundColor
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.register(OopsCell.self, forCellReuseIdentifier: "cell")
        feedTableView.separatorInset = UIEdgeInsets.zero
        feedTableView.theme_separatorColor = MyThemes.lineColor
        feedTableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(feedTableView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        feedTableView.pin.all()
    }

    @objc func shareDidTap(_ sender: UIButton) {
//        let f = feeds[sender.tag]
        print(sender.tag)

        let link = URL(string: "https://www.opsnft.net/xxxxx")!

        let vc = UIActivityViewController(activityItems: [link], applicationActivities: nil)
        present(vc, animated: true, completion: nil)
    }

    @objc func userHeadDidTap(_ sender: UITapGestureRecognizer) {
        print(sender.view?.tag ?? "None!")
        
        let vc = OtherUserInfoPage()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func menuDidTap(_ sender:UIButton) {
        OopsMenu(with: "", with: "me").show(onViewController: self, near: sender).userDidActionCallback {
            print($0, $1)
        }
    }
}

extension FeedPage: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabBarController_OPS?.scrollViewDidScroll(scrollView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OopsCell
        cell.setContent(index: indexPath.row)
        cell.shareButton.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)
        cell.userHeadTapGesture.addTarget(self, action: #selector(userHeadDidTap))
        cell.menuButton.addTarget(self, action: #selector(menuDidTap), for: .touchUpInside)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // The UITableView will call the cell's sizeThatFit() method to compute the height.
        // WANRING: You must also set the UITableView.estimatedRowHeight for this to work.
        return UITableView.automaticDimension
    }
}
