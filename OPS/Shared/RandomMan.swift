//
// Created by Aaron on 4/26/21.
//

import Foundation
func createRandomMan(start: Int, end: Int) -> () -> Int? {
    // 根据参数初始化可选值数组
    var nums = [Int]()
    for i in start ... end {
        nums.append(i)
    }

    func randomMan() -> Int! {
        if !nums.isEmpty {
            // 随机返回一个数，同时从数组里删除
            let index = Int(arc4random_uniform(UInt32(nums.count)))
            return nums.remove(at: index)
        } else {
            // 所有值都随机完则返回nil
            return nil
        }
    }

    return randomMan
}
