//
//  UserWallet.swift
//  Whoops
//
//  Created by Aaron on 4/25/21.
//

import Foundation

struct UserWallet: Codable {
    var privateKey: String
    var publicKey: String
    var address:String
    var words: String?
}
