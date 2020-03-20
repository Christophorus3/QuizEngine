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
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
        
    }

    func testOneQuestionRouteToCorrectQuestion() {
        
        let router = RouterSpy()
        let questions = ["Q1"]
        let sut = Flow(questions: questions,
                       router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
        
    }
    
    func testOneQuestionRouteToCorrectQuestion2() {
        
        let router = RouterSpy()
        let questions = ["Q2"]
        let sut = Flow(questions: questions,
                       router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
        
    }
    
    func testTwoQuestionsRouteToFirstQuestion() {
        
        let router = RouterSpy()
        let questions = ["Q1", "Q2"]
        let sut = Flow(questions: questions,
                       router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
        
    }
    
    func testStartTwiceTwoQuestionsRouteToFirstQuestion() {
        
        let router = RouterSpy()
        let questions = ["Q1", "Q2"]
        let sut = Flow(questions: questions,
                       router: router)
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
        
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        
        func routeTo(question: String) {
            routedQuestions.append(question)
        }
    }
}
