//
//  MessageViewController.swift
//  ShowMe
//
//  Created by Ульяна Цимбалистая on 05.12.2020.
//  Copyright © 2020 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var messagelabel: UILabel!
    var messageData: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagelabel.text = messageData
    }
}
