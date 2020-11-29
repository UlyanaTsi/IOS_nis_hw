//
//  DetailViewController.swift
//  CommitsApp
//
//  Created by Ульяна Цимбалистая on 29.11.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var detailItem: Commit?
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let detail = self.detailItem {
            detailLabel.text = detail.message
        }
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
