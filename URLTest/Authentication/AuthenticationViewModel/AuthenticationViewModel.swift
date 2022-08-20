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
    //let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
   // var parentViewController: UIViewController!
    var response = false
    
    func logInFirebase(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password){
            (result, error) in
            if let result = result, error == nil{
                self.response = true
                
                
            }
        }
    }
    
}


