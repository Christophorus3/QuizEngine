//
//  RouterSpy.swift
//  QuizEngineTests
//
//  Created by Christoph Wottawa on 29.09.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResults: Result<String, String>? = nil
    var answerCallback: (String) -> Void = { _ in }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(results: Result<String, String>) {
        routedResults = results
    }
}
