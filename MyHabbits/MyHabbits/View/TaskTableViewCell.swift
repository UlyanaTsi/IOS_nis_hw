//
//  TaskTableViewCell.swift
//  MyHabbits
//
//  Created by Ульяна Цимбалистая on 02.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet var taskName: UILabel!
    @IBOutlet var taskDate: UILabel!
    @IBOutlet var taskStatus: UIView!
    @IBOutlet var doneButton: UIButton!
    
    var isDone: Bool!
    var task: Task!
    
    var buttonAction: (() -> Void)?
    
    @IBAction func doneButtonPressed() {
        self.buttonAction!()
    }
    
    // Настраивает ячейку
    func setupCell(task: Task) {
        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        
        self.task = task
        self.taskName.text = task.name
        self.taskDate.text = task.date?.stringDate()
        
        // Цвет прямоугольника соответсвует статусу ячейки
        if (task.status == "New"){
            self.taskStatus.backgroundColor = UIColor.init(named: "newColor")
            self.doneButton.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
        if (task.status == "In progress"){
            self.taskStatus.backgroundColor = UIColor.init(named: "inProcessColor")
            self.doneButton.setImage(UIImage.init(systemName: "square"), for: .normal)
        }
        
        if (task.status == "Done"){
            self.taskStatus.backgroundColor = UIColor.init(named: "doneColor")
            self.isDone = true
            self.doneButton.setImage(UIImage.init(systemName: "checkmark.square"), for: .normal)
        } else {
            self.isDone = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
