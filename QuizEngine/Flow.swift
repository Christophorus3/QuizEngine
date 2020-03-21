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
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let self = self else { return }
                let nextQuestionIndex = self.questions.firstIndex(of: firstQuestion)! + 1
                let nextQuestion = self.questions[nextQuestionIndex]
                self.router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
