//
//  AddTaskViewController.swift
//  MyHabbits
//
//  Created by Ульяна Цимбалистая on 02.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var dateDatePicker: UIDatePicker!
    @IBOutlet var taskTextField: UITextField!
    
    var taskStatus: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Пользователь добавляет статус задачи
    @IBAction func doneButtonPressed() {
        taskStatus = "Done"
    }
    
    @IBAction func inProgressButtonPressed() {
        taskStatus = "In progress"
    }
    
    @IBAction func newButtonPressed() {
        taskStatus = "New"
    }
    
    // Пользавтель сохраняет задачу 
    @IBAction func saveButtonPressed() {
        if let taskName = taskTextField.text, !taskName.isEmpty{
            let taskDescription = descriptionTextView.text ?? " "
            let taskDate = dateDatePicker.date
            
            NotificationCenter.default.post(name: MainTableViewController.dataAddedNotification, object: nil, userInfo: ["name" : taskName, "text" : taskDescription, "date" : taskDate, "status" : taskStatus ?? "New"])
            
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
