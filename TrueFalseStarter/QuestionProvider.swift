//
//  QuestionProvider.swift
//  TrueFalseStarter
//
//  Created by Christine Plenge on 07/04/2018.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import GameKit

public struct QuestionProvider {
    
    var listOfQuestions = [
        QuestionType(question: "This was the only US President to serve more than two consecutive terms.", firstAnswer: "George Washington", secondAnswer: "Franklin D. Roosevelt", thirdAnswer: "Woodrow Wilson", fourthAnswer: "Andrew Jackson", correctAnswer: 2),
        QuestionType(question: "Which of the following countries has the most residents?", firstAnswer: "Nigeria", secondAnswer: "Russia", thirdAnswer: "Iran", fourthAnswer: "Vietnam", correctAnswer: 1),
        QuestionType(question: "In what year was the United Nations founded?", firstAnswer: "1918", secondAnswer: "1919", thirdAnswer: "1945", fourthAnswer: "1954", correctAnswer: 3),
        QuestionType(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", firstAnswer: "Paris", secondAnswer: "Washington D.C.", thirdAnswer: "New York", fourthAnswer: "Boston", correctAnswer: 3),
        QuestionType(question: "Which nation produces the most oil?", firstAnswer: "Iran", secondAnswer: "Iraq", thirdAnswer: "Brazil", fourthAnswer: "Canada", correctAnswer: 4),
        QuestionType(question: "Which country has most recently won consecutive World Cups in Soccer?", firstAnswer: "Italy", secondAnswer: "Brazil", thirdAnswer: "Argentina", fourthAnswer: "Spain", correctAnswer: 2),
        QuestionType(question: "Which of the following rivers is longest?", firstAnswer: "Yangtze", secondAnswer: "Mississippi", thirdAnswer: "Congo", fourthAnswer: "Mekong", correctAnswer: 2),
        QuestionType(question: "Which city is the oldest?", firstAnswer: "Mexico City", secondAnswer: "Cape Town", thirdAnswer: "San Juan", fourthAnswer: "Sydney", correctAnswer: 1),
        QuestionType(question: "Which country was the first to allow women to vote in national elections?", firstAnswer: "Poland", secondAnswer: "United States", thirdAnswer: "Sweden", fourthAnswer: "Senegal", correctAnswer: 1),
        QuestionType(question: "Which of these countries won the most medals in the 2012 Summer Games?", firstAnswer: "France", secondAnswer: "Germany", thirdAnswer: "Japan", fourthAnswer: "Great Britain", correctAnswer: 4),
    ]
    
    mutating func randomQuestion(label: UILabel, button1: UIButton, button2: UIButton, button3: UIButton, button4: UIButton, button5: UIButton) -> Int {
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: listOfQuestions.count)
        label.text = listOfQuestions[randomNumber].question
        button1.setTitle(listOfQuestions[randomNumber].firstAnswer, for: [])
        button2.setTitle(listOfQuestions[randomNumber].secondAnswer, for: [])
        button3.setTitle(listOfQuestions[randomNumber].thirdAnswer, for: [])
        button4.setTitle(listOfQuestions[randomNumber].fourthAnswer, for: [])
        button5.isHidden = true
        let answer = listOfQuestions[randomNumber].correctAnswer
        listOfQuestions.remove(at: randomNumber)
        return answer
    }
    
}
