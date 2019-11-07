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

struct Trapezoid: Shape {
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(firstInset, secondInset) }
        set {
            self.firstInset = newValue.first
            self.secondInset = newValue.second
        }
    }
    
    var firstInset: CGFloat = 0
    var secondInset: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: secondInset, y: rect.maxY))
        path.addLine(to: CGPoint(x: firstInset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - firstInset, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - secondInset, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct ContentView: View {
    @State private var amount: CGFloat = 0.5
    @State private var firstInset: CGFloat = 50
    @State private var secondInset: CGFloat = 50
    
    var body: some View {
        VStack {
            ZStack {
                Trapezoid(firstInset: firstInset, secondInset: secondInset)
                    .frame(width: 500 * amount, height: 100)
                    .offset(x: -80)
                    .foregroundColor(Color.red)
                    .blendMode(.screen)
                    .onTapGesture {
                        withAnimation(.linear) {
                            self.firstInset = CGFloat.random(in: 10...90)
                            self.secondInset = CGFloat.random(in: 10...90)
                        }
                }
                
                Trapezoid(firstInset: firstInset, secondInset: secondInset)
                    .frame(width: 500 * amount, height: 100)
                    .foregroundColor(Color.green)
                    .offset(x: 80)
                    .blendMode(.screen)
                    .onTapGesture {
                        withAnimation(.linear) {
                            self.firstInset = CGFloat.random(in: 10...90)
                            self.secondInset = CGFloat.random(in: 10...90)
                        }
                }
                
                Trapezoid(firstInset: firstInset, secondInset: secondInset)
                    .frame(width: 500 * amount, height: 100)
                    .foregroundColor(Color.blue)
                    .blendMode(.screen)
                    .onTapGesture {
                        withAnimation(.linear) {
                            self.firstInset = CGFloat.random(in: 10...90)
                            self.secondInset = CGFloat.random(in: 10...90)
                        }
                }
            }
            .frame(width: 300, height: 300)
            
            Slider(value: $amount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
