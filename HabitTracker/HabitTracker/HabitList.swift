//
//  HabitList.swift
//  HabitTracker
//
//  Created by Emilio Schepis on 10/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Combine
import UIKit

class HabitList: ObservableObject {
    @Published var habits: [Habit] = getHabitsFromUserDefaults() {
        didSet {
            Self.saveHabitsToUserDefaults(habits)
        }
    }
    
    private static func getHabitsFromUserDefaults() -> [Habit] {
        let data = UserDefaults.standard.data(forKey: "habits")
        
        let decoder = JSONDecoder()
        let habits = try? decoder.decode([Habit].self, from: data ?? Data())
        
        return habits ?? []
    }
    
    private static func saveHabitsToUserDefaults(_ habits: [Habit]) {
        let encoder = JSONEncoder()
        let data = try? encoder.encode(habits)
        
        UserDefaults.standard.set(data, forKey: "habits")
    }
}
