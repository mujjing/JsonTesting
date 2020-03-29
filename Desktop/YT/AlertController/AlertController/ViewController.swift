//
//  ViewController.swift
//  AlertController
//
//  Created by Jh's MacbookPro on 2020/03/28.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showAlertController(style: UIAlertController.Style){
        let alertController : UIAlertController
        alertController = UIAlertController(title: "title", message: "Message", preferredStyle: style)
        
        let okAction : UIAlertAction
        okAction = UIAlertAction(title: "Ok", style: .default, handler: {(action : UIAlertAction) in
            print("Ok Pressed")
        })
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField(configurationHandler: {(field : UITextField) in
            field.placeholder = "placeHoler"
            field.textColor = UIColor.red
        })
        
               alertController.addTextField(configurationHandler: {(field : UITextField) in
                   field.placeholder = "placeHoler2"
                   field.textColor = UIColor.red
               })
        
        self.present(alertController, animated: true, completion: nil)
        
    }

    
      @IBAction func touchupShowAlertButton(_ sender: UIButton){
          self.showAlertController(style: UIAlertController.Style.alert)
      }
    @IBAction func touchUpShowActionSheetButton(_ sender : UIButton){
        self.showAlertController(style: UIAlertController.Style.actionSheet)
    }
}

