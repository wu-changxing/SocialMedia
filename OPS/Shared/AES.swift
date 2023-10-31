//
//  AES.swift
//  Whoops
//
//  Created by Aaron on 4/25/21.
//

import Foundation
import CryptoSwift
typealias Base64String = String

class AES {
    static func encrypt(plainText: String, withPwd pwd: String) -> Base64String {
        let pwdSalt = pwd.sha1().subString(to: 16)
        let gcm = GCM(iv: Array(pwdSalt.utf8), mode: .combined)

        let aes = try! CryptoSwift.AES(key: Array(pwdSalt.utf8), blockMode: gcm, padding: .pkcs7)
        let encrypted = try! aes.encrypt(Array(plainText.utf8))
        //            let tag = gcm.authenticationTag
        let data = Data(bytes: encrypted, count: encrypted.count)

        return data.base64EncodedString()
    }

    static func decrypt(encrypted64: String, pwd: String) -> String? {
        let pwdSalt = pwd.sha1().subString(to: 16)
        let gcm = GCM(iv: Array(pwdSalt.utf8), mode: .combined)
        let aes = try? CryptoSwift.AES(key: Array(pwdSalt.utf8), blockMode: gcm, padding: .pkcs7)
        guard let data = Data(base64Encoded: encrypted64),
              let plain = try? aes?.decrypt(Array(data)) else { return nil }
        return String(bytes: plain, encoding: .utf8)
    }

    static func randomString(_ length: Int) -> String {
        let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String((0 ..< length).compactMap { _ in pswdChars.randomElement() })
    }
}
