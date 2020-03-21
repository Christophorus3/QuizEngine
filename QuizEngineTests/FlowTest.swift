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
    
    let router = RouterSpy()

    func testNoQuestionsNoRouting() {
        let sut = makeSUT(questions: [])

        sut.start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }

    func testOneQuestionRouteToCorrectQuestion() {
        let questions = ["Q1"]
        let sut = makeSUT(questions: questions)

        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testOneQuestionRouteToCorrectQuestion2() {
        let questions = ["Q2"]
        let sut = makeSUT(questions: questions)

        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func testTwoQuestionsRouteToFirstQuestion() {
        let questions = ["Q1", "Q2"]
        let sut = makeSUT(questions: questions)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testStartTwiceTwoQuestionsRouteToFirstQuestion() {
        let questions = ["Q1", "Q2"]
        let sut = makeSUT(questions: questions)
        
        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func testStartWithAnserTwoQuestionsRouteToSecondQuestion() {
        let questions = ["Q1", "Q2"]
        let sut = makeSUT(questions: questions)
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    func makeSUT(questions: [String]) -> Flow {
        let sut = Flow(questions: questions, router: router)
        return sut
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: AnswerCallback = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
