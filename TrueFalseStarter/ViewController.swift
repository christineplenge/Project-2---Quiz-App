//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var FirstAnswerButton: UIButton!
    @IBOutlet weak var SecondAnswerButton: UIButton!
    @IBOutlet weak var ThirdAnswerButton: UIButton!
    @IBOutlet weak var FourthAnswerButton: UIButton!
    @IBOutlet weak var PlayAgainButton: UIButton!
    
    //Loading array of questions and initiating random generator
    var questionProvider = QuestionProvider()
    
    var finalAnswer: Int = 0
    
    let questionsPerRound = 10
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        playGameStartSound()
        finalAnswer = questionProvider.randomQuestion(label: questionField, button1: FirstAnswerButton, button2: SecondAnswerButton, button3: ThirdAnswerButton, button4: FourthAnswerButton, button5: PlayAgainButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        
        questionsAsked += 1 // Increment the questions asked counter
        
        if (sender === FirstAnswerButton &&  finalAnswer == 1) ||
            (sender === SecondAnswerButton && finalAnswer == 2) ||
            (sender === ThirdAnswerButton &&  finalAnswer == 3) ||
            (sender === FourthAnswerButton &&  finalAnswer == 4)
        {
            correctQuestions += 1
            questionField.text = "Correct!"
        } else {
            questionField.text = "Sorry, wrong answer!"
        }
        
        loadNextRoundWithDelay(seconds: 1)
    }

    
    
    func displayScore() {
        // Hide answer buttons
        FirstAnswerButton.isHidden = true
        SecondAnswerButton.isHidden = true
        ThirdAnswerButton.isHidden = true
        FourthAnswerButton.isHidden = true
        
        PlayAgainButton.isHidden = false    // Display play again button
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            questionProvider = QuestionProvider()
        } else {
            // Continue game
            finalAnswer = questionProvider.randomQuestion(label: questionField, button1: FirstAnswerButton, button2: SecondAnswerButton, button3: ThirdAnswerButton, button4: FourthAnswerButton, button5: PlayAgainButton)
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        FirstAnswerButton.isHidden = false
        SecondAnswerButton.isHidden = false
        ThirdAnswerButton.isHidden = false
        FourthAnswerButton.isHidden = false
        
        questionsAsked = 0
        correctQuestions = 0
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

