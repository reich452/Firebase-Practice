//
//  SurveyViewController.swift
//  HelloFirebaseTutorial
//
//  Created by Nick Reichard on 4/30/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var favoriteTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text, name.characters.count > 0,
            let favoriteEmoji = favoriteTextField.text, favoriteEmoji.characters.count > 0
            else { return }
        
        SurveyController.putResponseIntoAPI(name: name, favoriteEmoji: favoriteEmoji)
        nameTextField.text = ""
        favoriteTextField.text = ""
        
    }
}
