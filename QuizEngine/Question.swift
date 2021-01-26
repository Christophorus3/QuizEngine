//
//  Question.swift
//  QuizApp
//
//  Created by Christoph Wottawa on 25.11.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

public enum Question<T: Hashable> : Hashable {
    case singleAnswer(T)
    case multipleAnswer(T)
    
    public var hashValue: Int {
        switch self {
        case .singleAnswer(let value):
            return value.hashValue
        case .multipleAnswer(let value):
            return value.hashValue
        }
    }
}
