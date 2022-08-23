//
//  AuthenticationTokenResponse.swift
//  URLTest
//
//  Created by Adrian San Martin on 23/08/22.
//

import Foundation
struct AuthenticationTokenResponse: Codable {
    let success: Bool
    let expires_at: String
    let request_token: String
}
