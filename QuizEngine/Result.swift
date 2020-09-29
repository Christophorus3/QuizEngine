//
//  Result.swift
//  QuizEngine
//
//  Created by Christoph Wottawa on 29.09.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

struct Result<Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
