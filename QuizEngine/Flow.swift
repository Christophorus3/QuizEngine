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
}

class Flow {
    
    let router: Router
    let questions: [String]
    
    init(questions: [String],
         router: Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion, answerCallback: routeNext(firstQuestion))
        }
    }
    
    private func routeNext(_ question: String) -> AnswerCallback {
        return { [weak self] _ in
            guard let self = self else { return }
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                if currentQuestionIndex + 1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex + 1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(nextQuestion))
                }
            }
        }
    }
}
