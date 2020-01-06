//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Emilio Schepis on 13/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScore = 0
    @State private var rotations: [Double] = [0, 0, 0]
    @State private var opacities: [Double] = [1, 1, 1]
    @State private var scales: [CGFloat] = [1, 1, 1]
    @State private var buttonsEnabled: Bool = true
    @State private var countries = [
        "Estonia", "France", "Germany", "Ireland", "Italy",
        "Nigeria", "Poland", "Russia", "Spain", "UK", "US"
        ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                    Text("Current score: \(currentScore)")
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .top)
                ForEach(0..<3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(country: self.countries[number])
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                    }
                    .rotation3DEffect(.degrees(self.rotations[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.opacities[number])
                    .scaleEffect(self.scales[number], anchor: .center)
                    .animation(.easeInOut(duration: 1))
                    .disabled(!self.buttonsEnabled)
                }
                Spacer()
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func flagTapped(_ number: Int) {
        buttonsEnabled = false
        
        for i in 0..<3 where i != correctAnswer {
            opacities[i] = 0.3
        }
        
        if number == correctAnswer {
            currentScore += 1
            rotations[number] += 360
        } else {
            currentScore = 0
            scales[number] = 0.3
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { _ in
            self.scales = [1, 1, 1]
            self.opacities = [1, 1, 1]
            self.askQuestion()
            self.buttonsEnabled = true
        }
    }
}

struct FlagImage: View {
    let country: String
    
    var body: some View {
        Image(country)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
        .shadow(color: .black, radius: 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
