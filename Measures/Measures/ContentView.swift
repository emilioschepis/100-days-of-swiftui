//
//  ContentView.swift
//  Measures
//
//  Created by Emilio Schepis on 11/10/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = ""
    @State private var inputUnitType = 0
    @State private var outputUnitType = 0
    
    private let unitTypes = [
        "Celsius",
        "Fahrenheit",
        "Kelvin"
    ]
    
    private let units = [
        UnitTemperature.celsius,
        UnitTemperature.fahrenheit,
        UnitTemperature.kelvin
    ]
    
    private var formatter: MeasurementFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        
        let measurementFormatter = MeasurementFormatter()
        measurementFormatter.unitOptions = .providedUnit
        measurementFormatter.numberFormatter = numberFormatter
        
        return measurementFormatter
    }()
    
    private func calculateOutput() -> String {
        let input = Double(self.inputValue) ?? 0
        let inputUnit = self.units[self.inputUnitType]
        let outputUnit = self.units[self.outputUnitType]
        
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        
        return self.formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Input")) {
                    TextField("Input value", text: $inputValue)
                        .keyboardType(.decimalPad)
                    Picker("Input unit", selection: $inputUnitType) {
                        ForEach(0 ..< self.unitTypes.count) {
                            Text(self.unitTypes[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Output")) {
                    Picker("Output unit", selection: $outputUnitType) {
                        ForEach(0 ..< self.unitTypes.count) {
                            Text(self.unitTypes[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text(calculateOutput())
                }
            }.navigationBarTitle("Measures")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
