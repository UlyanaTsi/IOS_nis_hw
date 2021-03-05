//
//  UpdateTaskViewController.swift
//  MyHabbits
//
//  Created by Ульяна Цимбалистая on 05.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class UpdateTaskViewController: UIViewController {
    
    @IBOutlet var taskNameField: UITextField!
    @IBOutlet var taskTextView: UITextView!
    @IBOutlet var inProgressButton: FancyButton!
    @IBOutlet var newButton: FancyButton!
    @IBOutlet var doneButton: FancyButton!
    @IBOutlet var taskDatePicker: UIDatePicker!
    
    var task: Task?
    var taskStatus: String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let task = task {
            taskNameField.text = task.name
            taskTextView.text = task.text
        }
    }
    
    /*
        Пользователь меняет статус.
     */
    @IBAction func inProgressButtonPressed() {
        taskStatus = "In progress"
    }
    
    @IBAction func doneButtonPressed() {
        taskStatus = "Done"
    }
    
    @IBAction func newButtonPressed() {
        taskStatus = "New"
    }
    
    // Пользователь сохранил изменения  
    @IBAction func updateButtonPressed() {
        if let taskName = taskNameField.text, !taskName.isEmpty{
            let taskDescription = taskTextView.text ?? task?.text
            let taskDate = taskDatePicker.date
            
            NotificationCenter.default.post(name: MainTableViewController.dataChangedNotification, object: nil, userInfo: ["task" : task!, "name" : taskName, "text" : taskDescription!, "date" : taskDate, "status" : taskStatus ?? task!.status as Any])
            
            _ = navigationController?.popToRootViewController(animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
}
