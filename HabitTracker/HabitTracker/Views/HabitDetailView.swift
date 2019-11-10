//
//  HabitDetailView.swift
//  HabitTracker
//
//  Created by Emilio Schepis on 10/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct HabitDetailView: View {
    @Binding var habit: Habit
        
    var body: some View {
        Form {
            Text(habit.description)
            
            Section(header: Text("Your habit data")) {
                Stepper("Completed \(habit.counter) times", value: $habit.counter)
            }
        }
        .navigationBarTitle(habit.title)
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static let habit = Habit(title: "Title", description: "Description")
    
    static var previews: some View {
        HabitDetailView(habit: Binding.constant(habit))
    }
}
