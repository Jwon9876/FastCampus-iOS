//
//  LoginViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 최주원 on 2023/01/10.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [emailLoginButton, googleLoginButton, appleLoginButton].forEach{
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
            
        }
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // navigation bar hidden
        navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        // Firebase 인증
    }
    
}
