//
//  NewBanksViewController.swift
//  Akbank Test
//
//  Created by Görkem Karagöz on 1.08.2024.
//
import UIKit

class NewBanksViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    let banks = ["Garanti BBVA","QNB Finansbank","İş Bankası","VakıfBank"]
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       tableview.dataSource = self
       tableview.delegate = self
    
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
}
