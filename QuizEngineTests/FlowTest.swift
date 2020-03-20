//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by Christoph Wottawa on 20.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine

class FlowTest: XCTestCase {
    
    func testNoQuestionsNoRouting() {
        
        let router = RouterSpy()
        let sut = Flow(questions: [],
                       router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
        
    }
    
    func testOneQuestionRouteToQuestion() {

        let router = RouterSpy()
        let questions = ["Q1"]
        let sut = Flow(questions: questions,
                       router: router)

        sut.start()

        XCTAssertEqual(router.routedQuestionCount, 1)

    }
    
    func testOneQuestionRouteToCorrectQuestion() {
        
        let router = RouterSpy()
        let questions = ["Q1"]
        let sut = Flow(questions: questions,
                       router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, "Q1")
        
    }
    
    func testOneQuestionRouteToCorrectQuestion2() {
        
        let router = RouterSpy()
        let questions = ["Q2"]
        let sut = Flow(questions: questions,
                       router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestion, "Q2")
        
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String?
        
        func routeTo(question: String) {
            routedQuestionCount += 1
            routedQuestion = question
        }
    }
}
