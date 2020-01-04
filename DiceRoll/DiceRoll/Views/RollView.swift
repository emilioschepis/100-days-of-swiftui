//
//  RollView.swift
//  DiceRoll
//
//  Created by Emilio Schepis on 04/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct RollView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingSettingsSheet = false
    @State private var numberOfDice = 2
    @State private var diceSides = 6
    @State private var rotation: Double = 0
    @State private var offset: CGFloat = 0
    @State private var rolled = false
    
    // TODO: Optimize this
    @State private var rolls = [Int](repeating: 0, count: 10)
    
    var settingsButton: some View {
        Button(action: {
            self.showingSettingsSheet = true
        }) {
            Image(systemName: "gear")
        }
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                VStack {
                    HStack(spacing: 16) {
                        Button(action: self.roll) {
                            VStack {
                                Image(systemName: "play.fill")
                                Text("Roll")
                            }
                        }
                        .disabled(self.rolled)
                        Button(action: self.reset) {
                            VStack {
                                Image(systemName: "backward.end.fill")
                                Text("Reset")
                            }
                        }
                        .disabled(!self.rolled)
                    }
                    List {
                        ForEach(0..<self.numberOfDice, id: \.self) { index in
                            VStack(alignment: .trailing) {
                                DiceView(roll: self.rolls[index],
                                         sides: self.diceSides)
                                    .rotationEffect(.degrees(self.rotation))
                            }
                            .offset(x: self.offset * (geo.size.width - 128), y: 0)
                        }
                    }
                }
            }
            .navigationBarTitle("Dice")
            .navigationBarItems(trailing: settingsButton)
            .sheet(isPresented: $showingSettingsSheet, onDismiss: reset) {
                SettingsView(numberOfDice: self.$numberOfDice,
                             diceSides: self.$diceSides)
            }
        }
    }
    
    func reset() {
        rolled = false
        rolls = [Int](repeating: 0, count: 10)
        withAnimation {
            self.rotation = 0
            self.offset = 0
        }
    }
    
    func roll() {
        rolled = true
        rolls = rolls.map { _ in Int.random(in: 1...diceSides) }
        withAnimation {
            self.rotation += 360
            self.offset += 1
        }
        
        // Save rolls to Core Data
        let result = Result(context: moc)
        result.id = UUID()
        result.timestamp = Date()
        
        rolls.prefix(numberOfDice).forEach { roll in
            let dice = Dice(context: moc)
            dice.id = UUID()
            dice.sides = Int16(diceSides)
            dice.roll = Int16(roll)
            result.addToRolls(dice)
        }
        
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}

struct RollView_Previews: PreviewProvider {
    static var previews: some View {
        RollView()
    }
}
