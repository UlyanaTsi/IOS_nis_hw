//
//  TweetViewController.swift
//  SocialApp
//
//  Created by Ульяна Цимбалистая on 30.11.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var tweetAuthorname: UILabel!
    @IBOutlet weak var tweetAuthorAvatar: UIImageView!
    @IBOutlet weak var tweetText: UITextView!
    @IBAction func dismissView(_ sender: Any) {
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
