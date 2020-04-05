//
//  DetailViewController.swift
//  MVVMStudy
//
//  Created by Jh's MacbookPro on 2020/04/05.
//  Copyright © 2020 JH. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var colorNumber: UILabel!
    @IBOutlet weak var webBtn: UIButton!
    
    var model : ApiModel?
    
    var colorString : String?
    var name : String?
    var hexNumber : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.layer.backgroundColor = hexStringToUIColor(hex: model!.hex).cgColor
        self.colorName.text = model?.name
        self.colorNumber.text = model?.hex
        
        navigationItem.title = "Detail"
        
        imageView.layer.cornerRadius = 20.0
        webBtn.layer.cornerRadius = webBtn.bounds.size.height / 2
    
        webBtn.addTarget(self, action: #selector(btnLink), for: .touchUpInside)
        btnIsEnable()
        
    }

    func btnIsEnable(){
        
        if colorName.text == "EGGSHELL" || colorName.text == "YELLOW" || colorName.text == "UMBER" || colorName.text == "STRAW" || colorName.text == "THISTLE" || colorName.text == "LILAC" || colorName.text == "PERIWINKLE" {
            
            webBtn.isEnabled = true
            webBtn.isHidden = false
        }else{
            webBtn.isEnabled = false
            webBtn.isHidden = true
        }
        
    }
    
    
    @objc func btnLink(_ sender: UIButton ){
        
        let mainstoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainstoryboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController

        vc.urlString = colorName.text!
        present(vc, animated: true)
                           
    }
    
}
