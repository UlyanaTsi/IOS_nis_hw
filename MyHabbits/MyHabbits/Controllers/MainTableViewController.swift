//
//  MainTableViewController.swift
//  MyHabbits
//
//  Created by Ульяна Цимбалистая on 02.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {

    // Прогресс вью и бар, которые не работают, но они есть.
    // Тут есть ошибка, которая исчезнет если сбилдить проект.
    @IBOutlet var progressView: UIView!
    @IBOutlet var progressBar: TaskProgressView!
    
    // Notifications, для передачи данных между view
    static let dataAddedNotification = Notification.Name("dataAdded")
    static let dataChangedNotification = Notification.Name("updateTask")
    
    // Core Data
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [Task] = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // В хедере "видно" прогресс
        tableView.tableHeaderView = progressView
        
        // Добавляем notifications
        NotificationCenter.default.addObserver(self, selector: #selector(onAddNotification(notification:)), name: MainTableViewController.dataAddedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onUpdatedNotification(notification:)), name: MainTableViewController.dataChangedNotification, object: nil)
        
        getTasks()
    }
    
    // Обновление списка задач
    func getTasks(){
        do{
            tasks = try context.fetch(Task.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {}
    }
    
    // Добавление задачи
    func addTask(name: String, text: String, date: Date, status: String){
        let newTask = Task(context: context)
        newTask.name = name
        newTask.text = text
        newTask.date = date
        newTask.status = status
        
        save()
    }
    
    // Обновление задачи
    func updateTask(task: Task, newName: String, newText: String, newDate: Date, newStatus: String){
        task.name = newName
        task.text = newText
        task.date = newDate
        task.status = newStatus
        
        save()
    }
    
    // Сохранение контекста
    func save(){
        do {
            try context.save()
        } catch {}
        
        getTasks()
    }
    
    // MARK: все связанное с tableView
    override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            
            // Удаление из CoreData
            context.delete(tasks[indexPath.row])
            tasks.remove(at: indexPath.row)
            save()
            
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        default:
            return
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        
        // Действия при нажатии кнопки внутри ячейки, меняет статус задачи.
        cell.buttonAction = {
            if (task.status != "Done"){
                cell.taskStatus.backgroundColor = UIColor.init(named: "doneColor")
                cell.doneButton.setImage(UIImage.init(systemName: "checkmark.square"), for: .normal)
                cell.isDone = true
                task.status = "Done"
            } else {
                cell.taskStatus.backgroundColor = UIColor.init(named: "inProcessColor")
                cell.doneButton.setImage(UIImage.init(systemName: "square"), for: .normal)
                cell.isDone = false
                task.status = "In progress"
            }
            self.save()
        }

        // Создает красивую ячейку
        cell.setupCell(task: task)

        return cell
    }
    
    // При нажатии на ячейку открываются детали задачи и ее можно редактировать
    override func tableView(_ tableView: UITableView, didSelectRowAt: IndexPath){
        let task =  tasks[didSelectRowAt.row]
        
        performSegue(withIdentifier: "showDetails", sender: task)
    }
    
    // Переход на вью
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetails" {
            let controller = segue.destination as! UpdateTaskViewController
            controller.task = sender as? Task
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Настраиваем NavigationController
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowColor = .white

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    // Действия, когда пользователь сохраняет новую задачу, с помощью notifications
    // данные новой задачи передаются и обрабатываются здесь
    @objc func onAddNotification(notification:Notification)
    {
        var newTaskName: String!
        var newTaskText: String!
        var newTaskDate: Date!
        var newTaskStatus: String!
        
        if let data = notification.userInfo {
            for (name, property) in data {
                if (name as! String == "name"){
                    newTaskName = property as? String
                }
                
                if (name as! String == "text"){
                    newTaskText = property as? String
                }
                
                if (name as! String == "date"){
                    newTaskDate = property as? Date
                }
                
                if (name as! String == "status"){
                    newTaskStatus = property as? String
                }
            }
        }
        
        addTask(name: newTaskName, text: newTaskText, date: newTaskDate, status: newTaskStatus)
    }
    
    // Действия, когда пользователь обновляет задачу, с помощью notifications
    // данные задачи передаются и обрабатываются здесь
    @objc func onUpdatedNotification(notification:Notification)
    {
        var task: Task!
        var newTaskName: String!
        var newTaskText: String!
        var newTaskDate: Date!
        var newTaskStatus: String!
        
        if let data = notification.userInfo {
            for (name, property) in data {
                if (name as! String == "task"){
                    task = property as? Task
                }
                
                if (name as! String == "name"){
                    newTaskName = property as? String
                }
                
                if (name as! String == "text"){
                    newTaskText = property as? String
                }
                
                if (name as! String == "date"){
                    newTaskDate = property as? Date
                }
                
                if (name as! String == "status"){
                    newTaskStatus = property as? String
                }
            }
        }
        
        updateTask(task: task, newName: newTaskName, newText: newTaskText, newDate: newTaskDate, newStatus: newTaskStatus)
    }
}
