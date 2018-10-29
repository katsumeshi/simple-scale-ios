//
//  WeightViewModel.swift
//  SimpleScale
//
//  Created by Yuki Matsushita on 10/27/18.
//  Copyright © 2018 Yuki Matsushita. All rights reserved.
//

import RxSwift

struct WeightViewModel {
    
    var weight = Variable<String>("0")
    var isValid : Observable<Bool>
    
    init() {
        isValid = weight.asObservable().map {
            let weight = Double($0) ?? 0.0
            return 0.0 < weight && weight < 300.0
        }
    }
}
