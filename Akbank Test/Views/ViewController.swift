//
//  ViewController.swift
//  Akbank Test
//
//  Created by Görkem Karagöz on 31.07.2024.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty {
            
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                if let error = error {
                    // Hata mesajını göster
                    self.showAlert(title: "Giriş Yapılamadı", message: error.localizedDescription)
                    print("Giriş hatası: \(error.localizedDescription)")
                    return
                }
                
                // Giriş başarılı
                self.performSegue(withIdentifier: "toOtherBanksScreenVC", sender: nil)
            }
        } else {
            showAlert(title: "Hata", message: "E-posta ve şifre boş olamaz.")
        }
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toRegisterVC", sender: nil)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

