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
    
    func testStartWithNoQuestions() {
        
        let router = RouterSpy()
        let sut = Flow(router: router)
        
        sut.start()
        
        XCTAssertEqual(router.routedQuestionCount, 0)
        
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
    }
}
