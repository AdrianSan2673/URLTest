//
//  Account.swift
//  URLTest
//
//  Created by Adrian San Martin on 23/08/22.
//

import Foundation
struct Account : Codable {
    let id: Int
    let name: String?
    let username: String?

    var displayName: String {
        if let name = name, !name.isEmpty {
            return name
        }
        return username ?? "(uknown)"
    }
}
