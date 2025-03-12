//
//  ViewController.swift
//  QuizezRS
//
//  Created by Faidh Naife on 3/11/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var QNumberOverview: UILabel!

    @IBOutlet weak var Topic: UILabel!

    @IBOutlet weak var QuestionLiteral: UILabel!

    @IBOutlet var AnswerButtons: [UIButton]!

    @IBOutlet weak var ResetButton: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!

    let quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure button appearance
        for button in AnswerButtons {
            button.layer.cornerRadius = 8
            button.backgroundColor = UIColor.systemBlue
            button.setTitleColor(UIColor.white, for: .normal)
        }

        // Set up initial UI state
        updateUI()

        // Initially hide results elements
        QNumberOverview.isHidden = false
        // Show this
        ResetButton.isHidden = true
    }

    // MARK: - UI Updates
    func updateUI() {
        // Update question text
        QuestionLiteral.text = quizBrain.getCurrentQuestionText()

        // Update topic label
        Topic.text = "Topic: \(quizBrain.getCurrentQuestionTopic())"

        // Update answer buttons
        let answers = quizBrain.getCurrentQuestionAnswers()
        for i in 0..<AnswerButtons.count {
            AnswerButtons[i].setTitle(answers[i], for: .normal)
        }

        // Update progress label and progress bar
        let currentIndex = quizBrain.getCurrentQuestionIndex() + 1
        let total = quizBrain.getTotalQuestions()
        QNumberOverview.text = "Question \(currentIndex)/\(total)"
        progressView.progress = Float(currentIndex) / Float(total)
    }

    // MARK: - Answer Processing
    private func processAnswer(selectedIndex: Int, sender: UIButton) {
        // Check if answer is correct
        let isCorrect = quizBrain.checkAnswer(selectedIndex)

        // Visual feedback
        sender.backgroundColor = isCorrect ? UIColor.green.withAlphaComponent(0.7) : UIColor.red.withAlphaComponent(0.7)

        // Wait before  next question
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            sender.backgroundColor = UIColor.systemBlue

            // Check if this was the last question
            if self.quizBrain.isLastQuestion() {
                self.showResults()
            } else {
                // Move to next question
                self.quizBrain.nextQuestion()
                self.updateUI()
            }
        }
    }

    func showResults() {
        // Hide question elements
        QuestionLiteral.isHidden = true
        Topic.isHidden = true
        for button in AnswerButtons {
            button.isHidden = true
        }

        // Show results elements
        let score = quizBrain.getScore()
        let total = quizBrain.getTotalQuestions()
        QNumberOverview.text = "Your Score: \(score)/\(total)"
        QNumberOverview.isHidden = false
        ResetButton.isHidden = false
        progressView.isHidden = true
    }



    @IBAction func ButtonsActions(_ sender: UIButton) {
        guard let selectedIndex = AnswerButtons.firstIndex(of: sender) else { return }

        // Process the answer with the index
        processAnswer(selectedIndex: selectedIndex, sender: sender)
    }


    @IBAction func ResetButton(_ sender: UIButton) {
        quizBrain.resetQuiz()

        // Reset progress view
        progressView.progress = 0
        progressView.isHidden = false

        // Update the UI for the first question
        updateUI()

        // Hide results elements and show question elements
        ResetButton.isHidden = true
        QuestionLiteral.isHidden = false
        Topic.isHidden = false
        for button in AnswerButtons {
            button.isHidden = false
        }
    }
}
