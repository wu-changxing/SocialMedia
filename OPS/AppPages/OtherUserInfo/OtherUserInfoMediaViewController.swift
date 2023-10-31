//
//  OtherUserInfoMediaViewController.swift
//  OPS
//
//  Created by Jason on 2021/5/8.
//

import UIKit

class OtherUserInfoMediaViewController: UIViewController {
    
    let waterLayout = WCLWaterFallLayout.init(lineSpacing: 15, columnSpacing: 15, sectionInsets: UIEdgeInsets.zero)
    
    
    var  collectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: waterLayout)
        
        collectionView.register(OtherUserMediaCell.self, forCellWithReuseIdentifier: "cell")
        waterLayout.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.pin.left(0).right(0).top(0).bottom(0)
        view.addSubview(collectionView)
        
    }
     

}

extension OtherUserInfoMediaViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OtherUserMediaCell
        
        cell.setContent(url: "https://bing.ioliu.cn/v1/rand?w=800&h=1000&a0\(indexPath.row)")
        return cell;
    }
    
    
    
    
}

extension OtherUserInfoMediaViewController: WCLWaterFallLayoutDelegate {
    func columnOfWaterFall(_ collectionView: UICollectionView) -> Int {
        2
    }
    
    func waterFall(_ collectionView: UICollectionView, layout waterFallLayout: WCLWaterFallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(Int(arc4random() % 110 + 150))
    }
}


