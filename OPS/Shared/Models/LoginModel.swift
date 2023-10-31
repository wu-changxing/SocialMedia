//
//  LoginModel.swift
//  OPS
//
//  Created by Aaron on 5/2/21.
//

import Foundation

struct walletPkPost : Codable {
    let public_key_addr:String
}

struct walletPkRespond: Codable {
    let random_code:String
}

struct tokenPost: Codable {
    let public_key:String
    let sigenature:String
}



