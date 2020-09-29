//
//  Router.swift
//  QuizEngine
//
//  Created by Christoph Wottawa on 29.09.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    typealias AnswerCallback = (Answer) -> Void
    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(results: Result<Question, Answer>)
}
