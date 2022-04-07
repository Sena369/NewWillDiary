//
//  AddListViewController.swift
//  WillDiary
//
//  Created by 澤田世那 on 2022/03/31.
//

import UIKit

class AddListViewController: UIViewController {

    enum Mode {
        case Add
        case Edit
    }
    
    var mode = Mode.Add
    var detailedItem = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if mode == .Edit {
            detailedItemTextField.text = detailedItem
        }
    }
    
    @IBOutlet weak var detailedItemTextField: UITextField!
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        if mode == .Add {
            let identifier = "exitFromAddBySaveSegue"
            performSegue(withIdentifier: identifier, sender: sender)
        } else {
            let identifier = "exitFromEditBySaveSegue"
            performSegue(withIdentifier: identifier, sender: sender)
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        
        if mode == .Add {
            let identifier = "exitFromAddByCancelSegue"
            performSegue(withIdentifier: identifier, sender: sender)
        } else {
            let identifier = "exitFromEditByCancelSegue"
            performSegue(withIdentifier: identifier, sender: sender)
        }
    }
}
