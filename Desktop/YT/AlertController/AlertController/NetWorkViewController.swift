//
//  NetWorkViewController.swift
//  AlertController
//
//  Created by Jh's MacbookPro on 2020/03/28.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit

class NetWorkViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
   
    let cellIdentifier: String = "friendCell"
    var friends : [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        guard let url: URL = URL(string: "https://randomuser.me/api/?results=20&inc=name,email,picture") else {
            return
        }
        
        let session : URLSession = URLSession(configuration: .default)
        let datatask : URLSessionDataTask = session.dataTask(with: url) {(data, response, error) in

            if let error = error{
                print(error.localizedDescription)
                print(1)
                return
            }
            guard let data = data else {return}
            print(data)

            do{
                print(3)
                let apiResponse : APIResponse = try JSONDecoder().decode(APIResponse.self, from: data)
                print(apiResponse)

                self.friends = apiResponse.results

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            }catch (let err){
                print(err.localizedDescription)
                print(2)
            }
        }
        datatask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        let friend : Friend = self.friends[indexPath.row]
        cell.textLabel?.text = friend.name.full
        cell.detailTextLabel?.text = friend.email
        cell.imageView?.image = nil
        DispatchQueue.global().async {
            guard let imageURL : URL = URL(string: friend.picture.thumbnail) else {return }
            guard let imageData : Data = try? Data(contentsOf: imageURL) else {return }
        
        DispatchQueue.main.async {
            
            if let index : IndexPath = tableView.indexPath(for: cell){
                if index.row == indexPath.row{
                    cell.imageView?.image = UIImage(data: imageData)
                }
            }
            
        }
        
        }
        
        return cell
       }

}
