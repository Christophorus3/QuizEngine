//
//  Flow.swift
//  QuizEngine
//
//  Created by Christoph Wottawa on 20.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

typealias AnswerCallback = (String) -> Void

protocol Router {
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
    func routeTo(results: [String: String])
}

class Flow {
    private let router: Router
    private let questions: [String]
    private var results: [String: String] = [:]
    
    init(questions: [String],
         router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(from: firstQuestion))
        } else {
            router.routeTo(results: results)
        }
    }
    
    private func routeNext(from question: String) -> AnswerCallback {
        return { [weak self] answer in
            guard let self = self else { return }
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                self.results[question] = answer
                if currentQuestionIndex + 1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex + 1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
                } else {
                    self.router.routeTo(results: self.results)
                }
            }
        }
    }
}
