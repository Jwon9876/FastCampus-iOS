//
//  EnterEmailViewController.swift
//  SpotifyLoginSampleApp
//
//  Created by 최주원 on 2023/01/10.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController: UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "이메일/비밀번호 입력하기"
        self.navigationController?.navigationBar.tintColor = .black
        
        nextButton.layer.cornerRadius = 30
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate  = self
        
        emailTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        // Firebase email/password auth
        
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        // 신규 사용자 생성
        
        Auth.auth().createUser(withEmail: email, password: password){ [weak self] authResult, error in
            guard let self = self else { return }
            
            if let error = error {
                let code = (error as NSError).code
                
                switch code{
                    // 로그인 하기
                case 17007:
                    self.loginUser(withEmail: email, password: password)
                    
                default:
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else{
                self.showMainViewController()
            }
            
        }
    }
    
    private func showMainViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String){
        
        Auth.auth().signIn(withEmail: email, password: password){ [weak self] _, error in
            
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else{
                self.showMainViewController()
            }
        }
    }
    
    
}

extension EnterEmailViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let isEmailEmpty = emailTextField.text == ""
        let isPasswordEmpty = passwordTextField.text == ""
        
        nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
    }
}
