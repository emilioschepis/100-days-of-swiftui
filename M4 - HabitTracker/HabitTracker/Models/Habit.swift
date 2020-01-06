//
//  Habit.swift
//  HabitTracker
//
//  Created by Emilio Schepis on 10/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

struct Habit: Identifiable, Codable {
    let id = UUID()
    var title: String
    var description: String
    var counter = 0
}
