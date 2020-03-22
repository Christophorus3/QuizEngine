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
    
    func testStartWithAnswerFirstAndSecondQuestionRouteToSecondAndThirdQuestion() {
        let questions = ["Q1", "Q2", "Q3"]
        let sut = makeSUT(questions: questions)
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func testStartWithAnswerFirstQuestionDontRoute() {
        let questions = ["Q1"]
        let sut = makeSUT(questions: questions)
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func testNoQuestionsNoRoutingResult() {
        let sut = makeSUT(questions: [])
        
        sut.start()
        
        XCTAssertEqual(router.routedResults!, [:])
    }
    
    func testOneQuestionsRouteToNoResult() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        XCTAssertNil(router.routedResults)
    }
    
    func testTwoQuestionsRouteToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedResults!, ["Q1": "A1", "Q2": "A2"])
    }
    
    func testTwoQuestionsAnswerOneRouteToNoResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertNil(router.routedResults)
    }
    
    // MARK: - Helpers
    
    func makeSUT(questions: [String]) -> Flow {
        let sut = Flow(questions: questions, router: router)
        return sut
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResults: [String: String]? = nil
        var answerCallback: AnswerCallback = { _ in }
        
        func routeTo(question: String, answerCallback: @escaping AnswerCallback) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(results: [String : String]) {
            routedResults = results
        }
    }
}
