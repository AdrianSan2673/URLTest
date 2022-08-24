//
//  AuthenticationViewController.swift
//  URLTest
//
//  Created by Adrian San Martin on 18/08/22.
//

import UIKit
import Firebase
import FirebaseAuth
import AuthenticationServices
class AuthenticationViewController: UIViewController,ASWebAuthenticationPresentationContextProviding {
    
    
    
    @IBOutlet weak var IndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var writePassword: UITextField!
    @IBOutlet weak var writeUsername: UITextField!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var errorMessenge: UILabel!
    
    let apiKey = "6211d940adfd49ac181b6546b14ff89d"
    let getTokenMethod = "authentication/token/new"
    let baseURLSecureString = "https://api.themoviedb.org/3/"
    var requestToken: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
        logoImg.image = UIImage(named: "theMovie")
        errorMessenge.isHidden = true
        IndicatorView.isHidden = true
        
        //setupBinders()
        // Do any additional setup after loading the view.
    }
  
    func setGradientBackground() {
        let colorTop2 =  UIColor(red: 13.0/255.0, green: 37.0/255.0, blue: 63.0/255.0, alpha: 5.0).cgColor
        let colorTop =  UIColor(red: 1.0/255.0, green: 180.0/255.0, blue: 228.0/255.0, alpha: 5.0).cgColor
        let colorBottom = UIColor(red: 144.0/255.0, green: 206.0/255.0, blue: 161.0/255.0, alpha: 1.0).cgColor
                    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop2,colorTop, colorBottom]
        gradientLayer.locations = [0.1,0.5, 1.0]
        gradientLayer.frame = self.view.bounds
                
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
   
    
    @IBAction func logInAction(_ sender: Any) {
      guard let email = writeUsername.text, let password = writePassword.text else {
          print("write a email and password")
          return
          
      }
       
        
          Auth.auth().signIn(withEmail: email, password: password){
                (resultado, error) in
                if let resultado = resultado, error == nil{
                    self.IndicatorView.stopAnimating()
                    self.IndicatorView.isHidden = true
                    self.performSegue(withIdentifier: "MoviesSegue", sender: nil)
                } else {
                    self.IndicatorView.stopAnimating()
                    self.IndicatorView.isHidden = true
                    self.errorMessenge.isHidden = false
                }
            }
        
        IndicatorView.isHidden = false
        IndicatorView.startAnimating()
       
    }
   
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let email = self.writeUsername.text
        let MenuSegue = segue.destination as! MenuViewController
        MenuSegue.email = email
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        
        return view.window!
    }

}
