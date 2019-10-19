//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Emilio Schepis on 18/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMove = 0
    @State private var selectedOutcome = true
    @State private var currentTurn = 0 {
        didSet {
            progress = Double(currentTurn - 1) / Double(totalTurns)
        }
    }
    @State private var currentScore = 0
    @State private var showingGameOver = false
    @State private var progress = 0.0
    
    let moves = ["Rock", "Paper", "Scissors"]
    let moveEmojis = ["🧱", "📃", "✂️"]
    let totalTurns = 10
    
    func resetGame() {
        currentTurn = 0
        currentScore = 0
        
        nextTurn()
    }
    
    func nextTurn() {
        currentTurn += 1
        
        if currentTurn > totalTurns {
            self.showingGameOver = true
            return
        }
        
        selectedMove = Int.random(in: 0..<moves.count)
        selectedOutcome = Bool.random()
    }
    
    func playMove(_ move: String) {
        guard let moveIndex = moves.firstIndex(of: move) else {
            return
        }
        
        let movementDirection = selectedOutcome ? +1 : -1
        let correctIndex = ((selectedMove + movementDirection) + moves.count) % moves.count
        
        if Int(moveIndex) == correctIndex {
            currentScore += 1
        } else {
            currentScore -= 1
        }
        
        nextTurn()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text("\(currentScore)")
                .font(.largeTitle)
            ProgressBar(progress: $progress)
            Text("You should \(selectedOutcome ? "win" : "lose") against my \(moves[selectedMove].lowercased())!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            HStack {
                ForEach(0 ..< moves.count) { index in
                    Button(action: {
                        self.playMove(self.moves[index])
                    }) {
                        Text(self.moveEmojis[index])
                            .font(.system(size: 32))
                    }
                }
            }
        }
        .alert(isPresented: $showingGameOver) {
            Alert(title: Text("Game over."),
                  message: Text("You scored \(currentScore) points."),
                  dismissButton: .default(Text("OK"), action: {
                self.resetGame()
            }))
        }
        .onAppear(perform: nextTurn)
    }
}

struct ProgressBar: View {
    @Binding var progress: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                    .opacity(0.3)
                    .frame(width: geometry.size.width, height: 8)
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * CGFloat(self.progress), height: 8)
                    .animation(.easeInOut(duration: 0.5))
            }
            .cornerRadius(4)
        }
        .padding(.horizontal, 8)
        .frame(height: 8.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
