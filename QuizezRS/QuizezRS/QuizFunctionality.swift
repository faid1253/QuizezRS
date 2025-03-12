//
//  QuizFunctionality.swift
//  QuizezRS
//
//  Created by Faidh Naife on 3/11/25.
//

import Foundation
import UIKit

struct Question {
    let text: String
    let topic: String
    let answers: [String]
    let correctAnswerIndex: Int
}

class QuizBrain {
    private var questions = [
        Question(
            text: "Which planet is known as the Red Planet?",
            topic: "Astronomy",
            answers: ["Venus", "Mars", "Jupiter", "Saturn"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What is the largest ocean on Earth?",
            topic: "Geography",
            answers: ["Atlantic Ocean", "Indian Ocean", "Arctic Ocean", "Pacific Ocean"],
            correctAnswerIndex: 3
        ),
        Question(
            text: "Which animal is known as the 'King of the Jungle'?",
            topic: "Wildlife",
            answers: ["Tiger", "Lion", "Elephant", "Leopard"],
            correctAnswerIndex: 1
        ),
        Question(
            text: "What is the capital of Japan?",
            topic: "Geography",
            answers: ["Seoul", "Beijing", "Tokyo", "Bangkok"],
            correctAnswerIndex: 2
        ),
        Question(
            text: "Who painted the Mona Lisa?",
            topic: "Art History",
            answers: ["Vincent van Gogh", "Pablo Picasso", "Leonardo da Vinci", "Michelangelo"],
            correctAnswerIndex: 2
        )
    ]

    private var currentQuestionIndex = 0
    private var score = 0

    func getCurrentQuestionText() -> String {
        return questions[currentQuestionIndex].text
    }

    func getCurrentQuestionTopic() -> String {
        return questions[currentQuestionIndex].topic
    }

    func getCurrentQuestionAnswers() -> [String] {
        return questions[currentQuestionIndex].answers
    }

    func getCurrentQuestionIndex() -> Int {
        return currentQuestionIndex
    }

    func getTotalQuestions() -> Int {
        return questions.count
    }

    func getScore() -> Int {
        return score
    }

    func checkAnswer(_ selectedIndex: Int) -> Bool {
        let correctIndex = questions[currentQuestionIndex].correctAnswerIndex
        if selectedIndex == correctIndex {
            score += 1
            return true
        }
        return false
    }

    func nextQuestion() {
        if currentQuestionIndex + 1 < questions.count {
            currentQuestionIndex += 1
        }
    }

    func isLastQuestion() -> Bool {
        return currentQuestionIndex == questions.count - 1
    }

    func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
    }
}


