//
//  String+Extension.swift
//  Whoops
//
//  Created by Aaron on 4/25/21.
//

import Foundation
extension String {
    
    /// oop中字数计算，英文计1，cjk记 2
    var countOOP: Int {
        self.reduce(0) { $0 + ($1.isASCII ? 1 : 2) }
    }
    /// 用数字切字符串 [0,count)
    ///
    /// - Parameters:
    ///   - from: 开始位置，最小为0
    ///   - to: 结束位置，最大为字符串长度
    /// - Returns: 返回新的字符串
    func subString(from:Int,to:Int) -> String {
        guard from < to && to <= self.count else {return ""}
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex ..< endIndex])
    }
    
    /// 从某位置开始直到字符串的末尾
    ///
    /// - Parameter from: 最小为0，最大不能超过字符串长度
    /// - Returns: 新的字符串
    func subString(from: Int) -> String {
        String(self.dropFirst(from))
    }

    /// 从头开始直到某位置停止，不包含索引位置(0,int),如果是负数则从后往前数n位
    ///
    /// - Parameter to: 要停止的位置，不包含这个位置
    /// - Returns: 新的字符串
    func subString(to: Int) -> String {
        if to < 0 {
            return String(self.dropLast(-to))
        }
        guard to <= self.count else { return "" }
        let endIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[startIndex ..< endIndex])
    }
}
