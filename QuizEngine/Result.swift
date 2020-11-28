//
//  Result.swift
//  QuizEngine
//
//  Created by Christoph Wottawa on 29.09.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

public struct Result<Question: Hashable, Answer> {
    public var answers: [Question: Answer]
    public var score: Int
    
    public init(answers: [Question: Answer], score: Int) {
        self.answers = answers
        self.score = score
    }
}
