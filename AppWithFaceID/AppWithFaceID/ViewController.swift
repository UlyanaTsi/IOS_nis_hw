//
//  ViewController.swift
//  AppWithFaceID
//
//  Created by Ульяна Цимбалистая on 24.02.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var faceIDButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Метод отвечающий за вход по Face ID по нажатию кнопки.
    @IBAction func useFaceID(_ sender: Any) {
        // Создали контекст проверки.
        let context = LAContext()
        var error: NSError?
        
        // Проверяем возможность использовать биометрическую аутентификацию,
        // в error передается указатель на ошибку.
        // Reason - причина использование аутентификации
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authentication") { [weak self] success, authentificationError in
                DispatchQueue.main.async {
                    if success{
                        // Действия, если пользоваетль прошел аутентификацию.
                        self?.logIn()
                    } else {
                        // Действия, если пользоваетль не прошел аутентификацию.
                        self?.textLabel.text = "Failed"
                    }
                    self?.textLabel.text = "Try agian"
                }
            }
        } else {
            // Если невозможно использовать биометрию.
        }
    }
    
    func logIn(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoggedInViewController") as UIViewController
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
}
