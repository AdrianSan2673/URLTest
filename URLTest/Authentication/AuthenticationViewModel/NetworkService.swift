//
//  NetworkService.swift
//  URLTest
//
//  Created by Adrian San Martin on 23/08/22.
//

import Foundation
import Firebase
import FirebaseAuth

struct APICLient{
    static let shared = APICLient()
    let session = URLSession(configuration: .default)
    
    func createRequestToken(_ completion: @escaping (ResultResponse<AuthenticationTokenResponse>) -> ()){
    do{
        let request = try Request.configureRequest(from: .token, with: [:], and: .get, contains: nil)
        session.dataTask(with: request) { (data, response, error) in

          if let response = response as? HTTPURLResponse, let data = data {
              let result = Response.handleResponse(for: response)
              switch result {
              case .success:
                  let result = try? JSONDecoder().decode(AuthenticationTokenResponse.self, from: data)
                  completion(ResultResponse.success(result!))
                  print(result)
                  

              case .failure:
                  completion(ResultResponse.failure(NetworkError.decodingFailed))
              }
          }
        }.resume()
    }catch{
        completion(ResultResponse.failure(NetworkError.badRequest))
    }
    }
    func createSession(requestToken: String, _ completion: @escaping (ResultResponse<CreateSessionResponse>) -> Void){}
    
}
