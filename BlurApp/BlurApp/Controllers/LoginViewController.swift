//
//  ViewController.swift
//  BlurApp
//
//  Created by Ульяна Цимбалистая on 31.01.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var backgroundImageView : UIImageView!
    @IBOutlet var signInButton : UIButton!
    
    var blurEffectView: UIVisualEffectView?
    
    let imageSet = ["forest1", "forest2", "forest3", "mountains1", "mountains2", "mountains3", "beach", "cartoon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // выбираем случайное изображение
        let selectedImageIndex = Int(arc4random_uniform(8))
        // эффект сглаживания
        backgroundImageView.image = UIImage(named: imageSet[selectedImageIndex])
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView!)
        
        // округлая кнопочка
        signInButton.layer.cornerRadius = 15.0
        signInButton.layer.masksToBounds = true
    }
}
