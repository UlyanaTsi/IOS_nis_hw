//
//  AutentificationViewContollerViewController.swift
//  AppWithFaceID
//
//  Created by Ульяна Цимбалистая on 24.02.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit
import LocalAuthentication

class AutentificationViewContollerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func authWithFaceID(_ sender: UIButton) {
        print("pressed")
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Autentification") {(success, error) in
                if success{
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    guard let error = error
                        else { return }
                    print(error.localizedDescription)
                }
                
            }
        }
    }
    
    
    @IBAction func useFaceID(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
