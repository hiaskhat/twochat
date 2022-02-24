//
//  ViewController.swift
//  TwoChat
//
//  Created by Асхат Баймуканов on 21.02.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
                titleLabel.text = ""
                let titleText = "⚡️TwoChat"
                var charIndex = 0.0
                for letter in titleText {
                    Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                        self.titleLabel.text?.append(letter)
                    }
                    charIndex += 1
                    //using charIndex now every letter has his time when appear. 0.0, 0.1, 0.2..)
                }
    }


}

