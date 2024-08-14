//
//  NewBanksViewController.swift
//  Akbank Test
//
//  Created by Görkem Karagöz on 1.08.2024.
//

import UIKit
import Firebase
import DZNEmptyDataSet
import FirebaseAuth
import FirebaseFirestore

class NewBanksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    var banks: [String] = []
    var shouldShowEmptyDataSet = false
    var isLoading = true

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.dataSource = self
        tableview.delegate = self
        tableview.emptyDataSetSource = self
        tableview.emptyDataSetDelegate = self
        tableview.tableFooterView = UIView() // Boş hücreleri gizlemek için
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        fetchUserBanks()
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "toNewAddBankVC", sender: nil)
    }
    
    func fetchUserBanks() {
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        isLoading = true
        
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).collection("addedBanks").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                self.banks = querySnapshot?.documents.compactMap { document -> String? in
                    let data = document.data()
                    return data["name"] as? String
                } ?? []
                
                self.shouldShowEmptyDataSet = self.banks.isEmpty
                self.isLoading = false
                
                DispatchQueue.main.async {
                    self.updateTableView()
                }
            }
        }
    }

    func updateTableView() {
        tableview.reloadData()
        indicatorView.stopAnimating()
        indicatorView.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = banks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let userId = Auth.auth().currentUser?.uid else { return }
            let bankNameToDelete = banks[indexPath.row]

            let db = Firestore.firestore()
            db.collection("users").document(userId).collection("addedBanks").whereField("name", isEqualTo: bankNameToDelete).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print("Error deleting document: \(error)")
                } else if let document = querySnapshot?.documents.first {
                    document.reference.delete { error in
                        if let error = error {
                            print("Error removing document: \(error)")
                        } else {
                            self.banks.remove(at: indexPath.row)
                            self.shouldShowEmptyDataSet = self.banks.isEmpty
                            DispatchQueue.main.async {
                                self.updateTableView()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // DZNEmptyDataSetSource metodları
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return !isLoading && shouldShowEmptyDataSet
    }

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let title = "Herhangi bir banka eklenmedi."
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .medium),
            .foregroundColor: UIColor.gray
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let description = "Lütfen yeni bir banka ekleyin."
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.lightGray
        ]
        return NSAttributedString(string: description, attributes: attributes)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(systemName: "banknote") // Placeholder için ikon ekleyebilirsiniz
    }
    
    func emptyDataSetShouldAllowTouch(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}


