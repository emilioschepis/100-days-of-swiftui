//
//  ContentView.swift
//  Drawing
//
//  Created by Emilio Schepis on 05/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct Arc: InsettableShape {
    var insetAmount: CGFloat = 0
    
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment

        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)

        return path
    }
}

struct ContentView: View {
    @State private var amount = 0.0
    
    var body: some View {
        VStack {
            Arc(startAngle: .degrees(0), endAngle: .degrees(amount * 360), clockwise: true)
            .strokeBorder(Color.blue, lineWidth: 30)
            Slider(value: $amount, minimumValueLabel: Text("0"), maximumValueLabel: Text("360")) {
                Text("Hello")
            }
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
