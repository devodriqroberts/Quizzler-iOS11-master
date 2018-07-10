//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer = false
    var questionNumber = 0
    var score = 0
    
  
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startingUI()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        var response: Bool?
            if sender.tag == 1 {
               response = true
            } else if sender.tag == 2 {
                response = false
            }
        if response != nil {
        checkAnswer(withResponse: response!)
        }
        
        questionNumber += 1
        nextQuestion(withIndex: questionNumber)
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber + 1) / \(allQuestions.list.count)"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(allQuestions.list.count) * CGFloat(questionNumber + 1))
      
    }
    

    func nextQuestion(withIndex: Int) {
        let questionLength = allQuestions.list.count
        if questionNumber < questionLength {
            questionLabel.text = allQuestions.list[questionNumber].questionText
        } else {

            let alert = UIAlertController(title: "Awesome", message: "You have answered all the questions, your score is \(score)/\(questionLength). Would you like to play again?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart Game", style: .default) { (UIAlertActin) in
                self.startOver()
            }
            alert.addAction(restartAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func checkAnswer(withResponse response: Bool) {
            if response == allQuestions.list[questionNumber].answer {
               score += 1
                ProgressHUD.showSuccess("Correct")
            } else {
                
                ProgressHUD.showError("Wrong")
            }
        updateUI()
    }
    
    func startingUI() {
        scoreLabel.text = "Score: 0"
        progressLabel.text = "\(questionNumber) / \(allQuestions.list.count)"
        nextQuestion(withIndex: questionNumber)
        progressBar.frame.size.width = 0
    }
    
    
    func startOver() {
        score = 0
        questionNumber = 0
        startingUI()
    }
    
    
}



extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}



