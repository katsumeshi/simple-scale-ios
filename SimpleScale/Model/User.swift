//
//  User.swift
//  SimpleScale
//
//  Created by Yuki Matsushita on 11/2/18.
//  Copyright © 2018 Yuki Matsushita. All rights reserved.
//

import Foundation

struct Scale: Codable {
    let weight: Double
    let date: Date
    init(weight: Double, date: Date) {
        self.weight = weight
        self.date = date
    }
}

struct User: Codable {
    let height: Double
    let alerts: [String]
    var scale: [Scale]
    
    init() {
        height = 0
        alerts = []
        scale = []
    }
    
    init(user: User) {
        height = user.height
        alerts = user.alerts
        scale = user.scale
    }
}
