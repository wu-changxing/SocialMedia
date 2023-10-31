//
//  OtherUserInfoOopViewController.swift
//  OPS
//
//  Created by Jason on 2021/5/8.
//

import UIKit

class OtherUserInfoOopViewController: ThemedUIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.theme_backgroundColor = MyThemes.textInputBackgroundColor
        tableView.theme_backgroundColor = MyThemes.textInputBackgroundColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(OopsCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.theme_separatorColor = MyThemes.lineColor
        tableView.estimatedRowHeight = UITableView.automaticDimension
        view.addSubview(tableView)
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

extension OtherUserInfoOopViewController: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tabBarController_OPS?.scrollViewDidScroll(scrollView)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
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

