//
//  QuizView.swift
//  AnimalTables
//
//  Created by Emilio Schepis on 29/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct QuizView: View {
    @Binding var tables: Int
    @Binding var settingUp: Bool
    let quizzesCount: Int
    
    // Quizzes
    @State private var generatedQuizzes = [(Int, Int)]()
    
    // Current quiz
    @State private var multiplicand: Int = 0
    @State private var multiplier: Int = 0
    @State private var product: Int = 0
    
    // Current game
    @State private var answer: String = ""
    @State private var score: Int = 0
    
    // Animations
    @State private var isAnimating: Bool = false
    @State private var isCheering: Bool = false
    
    // Alert
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var isGameOver: Bool = false
    
    func generateQuizzes() -> [(Int, Int)] {
        var quizzes = [(Int, Int)]()
        
        for i in 1...tables {
            for j in 1...10 {
                quizzes.append((i, j))
            }
        }
        
        return Array(quizzes.shuffled().prefix(self.quizzesCount))
    }
    
    func nextQuestion() {
        guard !generatedQuizzes.isEmpty else {
            // Game over
            alertTitle = "That's it!"
            alertMessage = "You scored \(score)/\(quizzesCount)"
            isGameOver = true
            return
        }
        
        let quiz = self.generatedQuizzes.removeLast()
        self.multiplicand = quiz.0
        self.multiplier = quiz.1
        self.product = (quiz.0 * quiz.1)
    }
    
    func answerQuiz() {
        guard let answer = Int(self.answer) else {
            return
        }
        
        if product == answer {
            isCheering = true
            score += 1
        }
        
        // Reset the text
        self.answer = ""
        
        withAnimation(.easeInOut(duration: 0.7)) {
            self.isAnimating = true
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            self.isCheering = false
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            
            withAnimation(.easeInOut(duration: 0.7)) {
                self.isAnimating = false
                self.nextQuestion()
            }
        }
    }
    
    func animalForNumber(_ number: Int) -> String {
        switch number {
        case 0...2:
            return "elephant"
        case 2...4:
            return "giraffe"
        case 4...6:
            return "zebra"
        case 6...8:
            return "horse"
        case 8...10:
            return "dog"
        case 10...12:
            return "chick"
        default:
            return "frog"
        }
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 32) {
                VStack(spacing: 16) {
                    AnimalRowView(isAnimating: $isAnimating, count: multiplicand, animal: animalForNumber(multiplicand))
                    HStack {
                        Text("\(multiplicand)")
                        Image(systemName: "multiply")
                        Text("\(multiplier)")
                    }
                    .opacity(isAnimating ? 0 : 1)
                    AnimalRowView(isAnimating: $isAnimating, count: multiplier, animal: animalForNumber(multiplicand))
                }
                .padding()
                TextField("Your answer", text: $answer, onCommit: answerQuiz)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isAnimating)
                    .padding()
                FansRowView(isCheering: $isCheering)
                Spacer()
            }
            .onAppear {
                self.generatedQuizzes = self.generateQuizzes()
                self.nextQuestion()
            }
        }
        .alert(isPresented: $isGameOver) {
            Alert(title: Text(alertTitle),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("Yay!"), action: { self.settingUp = true }))
        }
    }
}
