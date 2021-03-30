//
//  Question.swift
//  QuizApp
//
//  Created by Ульяна Цимбалистая on 30.03.2021.
//  Copyright © 2021 Ульяна Цимбалистая. All rights reserved.
//

import UIKit

class Question {
    var text : String = " "
    var answer : String = " "
    var opened : Bool = false
    
    init(text: String, answer : String){
        self.text = text
        self.answer = answer
    }
}
