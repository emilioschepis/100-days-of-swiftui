//
//  ContentView.swift
//  Animations
//
//  Created by Emilio Schepis on 26/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 300
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(
                        LinearGradient(gradient:
                            Gradient(colors: [
                                self.color(for: value, brightness: 1),
                            ]), startPoint: .top, endPoint: .bottom),
                        lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Flower: Shape {
    // Distance of this petal from the center.
    var petalOffset: Double = -20
    
    // Width of this petal.
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for number in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 8) {
            // Rotate the shape by the current value of the loop.
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // Move the petal to be in the center of the view.
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            // Create the path for this petal.
            let originalPetal = Path(ellipseIn: CGRect(x: CGFloat(petalOffset), y: 0, width: CGFloat(petalWidth), height: rect.width / 2))
            
            // Apply the transforms to the original petal.
            let rotatedPetal = originalPetal.applying(position)
            
            path.addPath(rotatedPetal)
        }
        
        return path
    }
}

struct ContentView: View {
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                ColorCyclingCircle(amount: colorCycle)
               Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                .fill(Color.white, style: FillStyle(eoFill: true))
            }

            Text("Offset")
            Slider(value: $petalOffset, in: -20...20).padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100).padding(.horizontal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
