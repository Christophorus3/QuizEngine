//
//  Game.swift
//  QuizEngine
//
//  Created by Christoph Wottawa on 29.09.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

public class Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
    
    init(flow: Flow<Question, Answer, R>) {
        self.flow = flow
    }
}

public func startGame<Question, Answer, R: Router>(questions: [Question],
                                                             router: R,
                                                             correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: { _ in 0 })
    flow.start()
    return Game(flow: flow)
}
