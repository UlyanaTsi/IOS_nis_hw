//
//  ViewController.swift
//  QuizApp
//
//  Created by Ульяна Цимбалистая on 30.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    private var questions = [Question(text: "Ответ на главный вопрос вселенной", answer: "42"),
                             Question(text: "Почему маки в D106 такие медленные", answer: "Потому что это не школа дизайна"),
                             Question(text: "Я хочу кушать", answer: "да")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuestionCell
        
        
        cell.questionLabel.text = questions[indexPath.row].text
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        questions[indexPath.row].opened = !questions[indexPath.row].opened
        
        showAnswer(question: questions[indexPath.row])
    }
    
    func showAnswer(question: Question){
        
        answerLabel.text = question.answer
        
        if (question.opened ){
            answerLabel.isHidden = false
        }
        else {
            answerLabel.isHidden = true
        }
    }
}

