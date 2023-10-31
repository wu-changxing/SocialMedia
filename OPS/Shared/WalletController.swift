//
//  WalletController.swift
//  Whoops
//
//  Created by Aaron on 4/25/21.
//

import Foundation
import WalletCore
import CryptoSwift

class WalletController {
    init() {

        let w = HDWallet(mnemonic: "tuna night replace noise offer raccoon ordinary once phone warm symptom collect", passphrase: "")
               let p = w.getKeyForCoin(coin: .ethereum)

               let dataString = "HrWVmeCAbOAMPDdOi36NYE4RnxaHnLeo0PnGqvXf9n2ONjub7BOteFXQqOIkzqwubaAE7rsn6qD36eoH8De7VK4oi8IUQgtsxzzNuCVMJLRyRDTPeiD4aBIftE79vHGk"
               guard let data = dataString.data(using: .utf8) else {
                   print("Failed to convert string to data.")
                   return
               }

               print("msg: testtesttest!!!, hex: \(data.hexString)")
               guard let d = p.sign(digest: data.sha3(.sha256), curve: .secp256k1) else {
                   print("Failed to sign data.")
                   return
               }

               print("hash data: \(data.sha3(.sha256).hexString)")
               print("sign data: ", d.hexString)

               let pp = p.getPublicKeySecp256k1(compressed: false)
               print("public key: ", pp.data.hexString)

               let r = pp.verify(signature: d, message: data.sha3(.sha256))
               print(r)

               print("address: ", w.getAddressForCoin(coin: .ethereum))
               print(CoinType.ethereum.deriveAddressFromPublicKey(publicKey: pp))

               let hash = pp.data.dropFirst().sha3(.keccak256).suffix(from: 12)
               print("new address: 0x\(hash.hexString)")
//
//
//
//
//        let s = AES.encrypt(plainText: "123123", withPwd: "888")
//        print(AES.decrypt(encrypted64: s, pwd: "888"))
//        let s = StoredKey.importPrivateKey(privateKey: w.getKeyForCoin(coin: .ethereum).data, name: "whoops wallet", password: "123123123".data(using: .utf8)!, coin: .ethereum)
//        print(String(data: s!.exportJSON()!, encoding: .utf8))
//        let keystore = "{\"activeAccounts\":[{\"ad1dress\":\"0xC2d6e0D025aAd98363F2F778B22c027B40CE5870\",\"coin\":60,\"derivationPath\":\"m/44\'/60\'/0\'/0/0\"}],\"crypto\":{\"cipher\":\"aes-128-ctr\",\"cipherparams\":{\"iv\":\"08510f7e24f088e46745fe481fd7e671\"},\"ciphertext\":\"fda93eddbad4e85c4d3dbcbea55432bb455d1da6307414ef4f98e6887b708c23\",\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,\"n\":4096,\"p\":6,\"r\":8,\"salt\":\"cac1fe0c922df1a36253fee3b7bced\"},\"mac\":\"7138fdd603adad6b7cdf4bafec6d8596729d6b1b1987819e76201589ed3d4ca0\"},\"id\":\"1f3c1077-8862-4a86-89db-6e4b3397cb34\",\"name\":\"whoops wallet\",\"type\":\"private-key\",\"version\":3}".data(using: .utf8)
//
//        let s = StoredKey.importJSON(json: keystore!)!
//        let p = s.privateKey(coin: .ethereum, password: "123123123".data(using: .utf8)!)
//        print(w.getKeyForCoin(coin: .ethereum).data.hexString, p?.data.hexString)
        
    }
    static let kCurrentWallet = "CurrentWallet"
    
    static var hasWallet:Bool {getCurrentWallet() != nil}

    static func getCurrentWallet() -> UserWallet? {
        // 如果是nil说明用户没有开通钱包
        guard let data = UserDefaults.standard.data(forKey: kCurrentWallet),
              let uw = try? JSONDecoder().decode(UserWallet.self, from: data)
        else { return nil }
        return uw
    }

    static func saveAndReplace(privateKey: PrivateKey, words: [String]?, pwd: String) {
        let encryptedPK = AES.encrypt(plainText: privateKey.data.hexString, withPwd: pwd)

        let pubk = privateKey.getPublicKeySecp256k1(compressed: false)
        let address = CoinType.ethereum.deriveAddressFromPublicKey(publicKey: pubk)

        var wordsStr: String?
        if let w = words {
            let encryptedWd = AES.encrypt(plainText: w.joined(separator: " "), withPwd: pwd)
            wordsStr = encryptedWd
        } else {
            wordsStr = nil
        }

        let uw = UserWallet(privateKey: encryptedPK, publicKey: pubk.data.hexString, address: address, words: wordsStr)

        UserDefaults.standard.set(uw, forKey: kCurrentWallet)
        UserDefaults.standard.synchronize()
    }
}

extension WalletController {
    static func removeAll() {
        UserDefaults.standard.removeObject(forKey: kCurrentWallet)
        UserDefaults.standard.synchronize()
    }
    static func getAddress() -> String? {
        getCurrentWallet()?.address
    }

    static func getPublicKey() -> String? {
        getCurrentWallet()?.publicKey
    }

    static func hasWords() -> Bool {
        getCurrentWallet()?.words != nil
    }

    static func getWords(pwd: String) -> String? {
        guard let encoded = getCurrentWallet()?.words else {
            return nil
        }
        return AES.decrypt(encrypted64: encoded, pwd: pwd)
    }

    static func getPrivateKey(pwd: String) -> String? {
        guard let encoded = getCurrentWallet()?.privateKey else {
            return nil
        }
        return AES.decrypt(encrypted64: encoded, pwd: pwd)
    }
}
