//
//  Flow.swift
//  QuizEngine
//
//  Created by Christoph Wottawa on 20.03.20.
//  Copyright © 2020 Christoph Wottawa. All rights reserved.
//

import Foundation

protocol Router {
    
}

class Flow {
    
    let router: Router
    
    init(router: Router) {
        self.router = router
    }
    
    func start() {
        
    }
}
