//
//  ComposeViewController.swift
//  SocialApp
//
//  Created by Ульяна Цимбалистая on 30.11.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

   
    @IBOutlet weak var tweetContent: UITextView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postActivity: UIActivityIndicatorView!
    
    @IBAction func dismissView(_ sender: Any) {
    }
    
    @IBAction func postToTwitter(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
