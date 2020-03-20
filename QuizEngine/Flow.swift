//
//  Flow.swift
//  QuizEngine
//
//  Created by Christoph Wottawa on 20.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

protocol Router {
    func routeTo(question: String)
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
        if let question = questions.first {
            router.routeTo(question: question)
        }
    }
}
