 //
//  RegisterViewController.swift
//  Akbank Test
//
//  Created by Görkem Karagöz on 31.07.2024.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "toMainVc", sender: nil)
    }
    
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty,
           let name = nameTextField.text, !name.isEmpty,
           let surname = surnameTextField.text, !surname.isEmpty {
            
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
                guard let self = self else { return }
                
                if let error = error {
                    // Hata mesajını göster
                    self.showAlert(title: "Kayıt Hatası", message: error.localizedDescription)
                    print("Kayıt hatası: \(error.localizedDescription)")
                    return
                }
                
                // Kayıt başarılı
                self.showAlert(title: "Başarılı", message: "Kayıt işlemi başarılı.")
            }
        } else {
            showAlert(title: "Hata", message: "Tüm alanlar doldurulmalıdır.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

