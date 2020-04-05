//
//  ViewController.swift
//  MVVMStudy
//
//  Created by Jh's MacbookPro on 2020/04/03.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var model = [ApiModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Color List"
        self.activityIndicator.startAnimating()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let url = URL(string: "https://raw.githubusercontent.com/wlsdms0122/RxMVVM/develop/API/colors.json")
             URLSession.shared.dataTask(with: url!){ (data, response, error) in
                 
                 if error == nil{
                     do{
                     self.model = try JSONDecoder().decode([ApiModel].self, from: data!)
                     }catch{
                         print("error")
                     }
                     DispatchQueue.main.sync {
                         print(self.model.count)
                         self.tableview.reloadData()
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true

                     }
                 }
                 
             }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HexCell
        
        cell.colorView.layer.backgroundColor = hexStringToUIColor(hex: model[indexPath.row].hex).cgColor
        cell.colorName.text = model[indexPath.row].name
        cell.colorHex.text = model[indexPath.row].hex
        
        return cell
       }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "Detailsegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.model = model[(tableview.indexPathForSelectedRow?.row)!]
        }
    }

}

class HexCell : UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorHex: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        colorView.layer.cornerRadius = 10.0
    }
}


