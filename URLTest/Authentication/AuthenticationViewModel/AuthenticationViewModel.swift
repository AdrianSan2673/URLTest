//
//  AuthenticationViewModel.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthenticationViewModel {
   
    var error: ObservavleObjetc<String?> = ObservavleObjetc(nil)
    
    func logIn(email: String, password: String){
        NetWorkservise.shared.login(email: email, password: password) { [weak self] success in
            self?.error.value = success ? nil : "Error"
        }
    }
    
    
}


