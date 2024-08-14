//
//  NewAddBankViewController.swift
//  Akbank Test
//
//  Created by Görkem Karagöz on 2.08.2024.
//
import UIKit
import Firebase
import FirebaseStorage
import FirebaseAuth
import FirebaseCore

class NewAddBankViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    struct NewBank {
        let title: String
        let imageName: String
    }
    
    var data: [NewBank] = []
    var addedBanks: Set<String> = [] // Eklenen bankaları takip etmek için
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchAddedBanks() // Kullanıcının eklediği bankaları çek
    }
    
    func fetchAddedBanks() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("addedBanks").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting added banks: \(error)")
            } else {
                self.addedBanks = Set(querySnapshot?.documents.compactMap { document -> String? in
                    let data = document.data()
                    return data["name"] as? String
                } ?? [])
                
                self.fetchBanks() // Bankaları eklenenlere göre güncelle
            }
        }
    }
    
    func fetchBanks() {
        let db = Firestore.firestore()
        
        db.collection("Banks").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.data = querySnapshot?.documents.compactMap { document -> NewBank? in
                    let data = document.data()
                    guard let title = data["name"] as? String, let imageName = data["logoUrl"] as? String else {
                        return nil
                    }
                    // Eklenen bankaları hariç tut
                    guard !self.addedBanks.contains(title) else { return nil }
                    return NewBank(title: title, imageName: imageName)
                } ?? []
                
                // Reload the table view on the main thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newBank = data[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        
        cell.label.text = newBank.title
        
        let storageRef = Storage.storage().reference().child("bank_icons/\(newBank.imageName)")
        
        storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("Error downloading image: \(error)")
            } else if let data = data, let image = UIImage(data: data) {
                cell.iconİmageView.image = image
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBank = data[indexPath.row].title
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("addedBanks").addDocument(data: [
            "name": selectedBank
        ]) { error in
            if let error = error {
                print("Error adding bank: \(error)")
            } else {
                print("\(selectedBank) bankası başarıyla eklendi.")
                
                // Veriyi başarıyla ekledikten sonra, önceki ekrana dönüp tabloyu güncelle
                if let newBanksVC = self.navigationController?.viewControllers.first(where: { $0 is NewBanksViewController }) as? NewBanksViewController {
                    newBanksVC.fetchUserBanks()
                }
                
                // Uyarı ve geri dönüş
                let alert = UIAlertController(title: "Banka Eklendi", message: "\(selectedBank) bankası başarıyla eklendi.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .default) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

