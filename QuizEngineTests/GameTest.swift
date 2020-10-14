//
//  GameTest.swift
//  QuizEngineTests
//
//  Created by Christoph Wottawa on 29.09.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation
import XCTest
import QuizEngine

class GameTest: XCTest {
    
    func testStartGameOneOfTwoCorrectAnswersScoresOne() {
        let router = RouterSpy()
        _ = startGame(questions: ["Q1", "Q2"], router: router, correctAnswers: ["Q1": "A1", "Q2": "A2"])
        
        router.answerCallback("A1")
        router.answerCallback("wrong")
        
        XCTAssertEqual(router.routedResults!.score, 1)
    }
}
