//
//  ContentView.swift
//  Animations
//
//  Created by Emilio Schepis on 26/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var startPoint: UnitPoint = .top
    var endPoint: UnitPoint = .bottom
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient:
                        Gradient(colors: [
                            self.color(for: value, brightness: 1),
                            self.color(for: value, brightness: 0.5),
                        ]), startPoint: self.startPoint, endPoint: self.endPoint), lineWidth: 2)
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

struct Arrow: Shape {
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(lineWidth, angle) }
        set {
            self.lineWidth = newValue.first
            self.angle = newValue.second
        }
    }
    
    var lineWidth: CGFloat = 3
    var angle: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let pointY = rect.minY + (rect.height / 3)
        
        let rblCorner = CGPoint(x: rect.midX - 30, y: rect.maxY)
        let rbrCorner = CGPoint(x: rect.midX + 30, y: rect.maxY)
        let rtrCorner = CGPoint(x: rect.midX + 30, y: pointY)
        let rtlCorner = CGPoint(x: rect.midX - 30, y: pointY)
        let tlCorner = CGPoint(x: rect.minX + 30, y: pointY)
        let trCorner = CGPoint(x: rect.maxX - 30, y: pointY)
        let ttCorner = CGPoint(x: rect.midX, y: rect.minY)
        
        path.move(to: rblCorner)
        path.addLine(to: rbrCorner)
        path.addLine(to: rtrCorner)
        path.addLine(to: trCorner)
        path.addLine(to: ttCorner)
        path.addLine(to: tlCorner)
        path.addLine(to: rtlCorner)
        path.addLine(to: rblCorner)
        
        let strokedPath = path.strokedPath(.init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
        
        return strokedPath
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
    @State private var width: CGFloat = 3
    @State private var angle: Double = 0
    @State private var startPoint: UnitPoint = .top
    @State private var endPoint: UnitPoint = .bottom
    
    var body: some View {
        VStack(spacing: 30) {
            Arrow(lineWidth: width)
                .stroke(Color.white, style: StrokeStyle(lineWidth: width, lineCap: .round, lineJoin: .round))
                .foregroundColor(.white)
                .rotationEffect(.degrees(angle), anchor: .center)
                .frame(width: 300, height: 300)
            
            HStack(spacing: 30) {
                Button(action: {
                    withAnimation(.linear(duration: 0.5)) {
                        self.width = CGFloat.random(in: 1...10)
                    }
                }) {
                    Image(systemName: "arrow.left.and.right")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 30)
                    
                }
                
                Button(action: {
                    withAnimation(.spring()) {
                        self.angle = Double.random(in: 0...360)
                    }
                }) {
                    Image(systemName: "arrow.2.circlepath")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: 30)
                }
            }
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
