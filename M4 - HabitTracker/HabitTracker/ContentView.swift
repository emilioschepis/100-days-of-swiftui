//
//  ContentView.swift
//  HabitTracker
//
//  Created by Emilio Schepis on 10/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habitList = HabitList()
    @State private var showingNewHabit = false
    
    func deleteHabits(at offsets: IndexSet) {
        self.habitList.habits.remove(atOffsets: offsets)
    }
    
    func selectHabit(id: UUID) -> Binding<Habit> {
        guard let index = self.habitList.habits.firstIndex(where: { $0.id == id }) else {
            fatalError("This habit does not exist.")
        }
        
        return self.$habitList.habits[index]
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habitList.habits) { habit in
                    NavigationLink(destination: HabitDetailView(habit: self.selectHabit(id: habit.id))) {
                        Text(habit.title)
                    }
                }
                .onDelete(perform: deleteHabits)
            }
            .navigationBarTitle("Habits")
            .navigationBarItems(trailing: Button(action: {
                self.showingNewHabit.toggle()
            }) {
                Image(systemName: "plus")
            })
                .sheet(isPresented: $showingNewHabit) {
                    NewHabitView(habits: self.$habitList.habits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
