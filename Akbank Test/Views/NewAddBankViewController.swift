//
//  NewAddBankViewController.swift
//  Akbank Test
//
//  Created by Görkem Karagöz on 2.08.2024.
//

import UIKit

class NewAddBankViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    struct NewBank {
        let title: String
        let imageName: String
    }
    
    let data: [NewBank] = [
        NewBank(title: "Pokus", imageName: "pokuslogo"),
        NewBank(title: "Halkbank", imageName: "halkbank"),
        NewBank(title: "Ziraat Bankası", imageName: "ziraat"),
        NewBank(title: "HSBC", imageName: "hsbc"),
        NewBank(title: "DenizBank", imageName: "denizbank")
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Register the custom cell if not done in storyboard
        // tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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
        cell.iconİmageView.image = UIImage(named: newBank.imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: showAlert()
        case 1: print("Halkbank seçildi")
        case 2: print("Ziraat Bankası seçildi")
        case 3: print("HSBC seçildi")
        case 4: print("DenizBank seçildi")
        default:
            print("Herhangi bir banka seçilmedi")
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Açık Bankacılık", message: "Pokus uygulamasından Vaadesiz TL hesabı eklenecektir.", preferredStyle: .alert)
        let confirmation = UIAlertAction(title: "TAMAM", style: .default) { UIAlertAction in
            print("Pokus uygulamasından Vaadesiz TL hesabı eklenmiştir.")
        }
        let cancel = UIAlertAction(title: "İPTAL", style: .default) { UIAlertAction in
            print("Pokus uygulamasından Vaadesiz TL hesabı eklenmemiştir.")
        }
        
        alert.addAction(confirmation)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
}

