//
//  Response.swift
//  URLTest
//
//  Created by Adrian San Martin on 23/08/22.
//

import Foundation
enum ResultResponse<T> {
    case success(T)
    case failure(Error)
}

struct Response {

    static func handleResponse(for response: HTTPURLResponse?) -> ResultResponse<String>{

        guard let res = response else { return ResultResponse.failure(NetworkError.noResponse)}

        switch res.statusCode {
        case 200...299: return .success(NetworkError.success.rawValue)
        case 401: return .failure(NetworkError.authenticationError)
        case 400...499: return .failure(NetworkError.badRequest)
        case 500...599: return .failure(NetworkError.serverError)
        default: return .failure(NetworkError.failed)
        }
    }
}
