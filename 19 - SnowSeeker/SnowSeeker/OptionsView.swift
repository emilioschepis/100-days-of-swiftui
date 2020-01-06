//
//  OptionsView.swift
//  SnowSeeker
//
//  Created by Emilio Schepis on 05/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct OptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var sortingOption: SortingOptions
    @Binding var favoriteFilter: Bool
    @Binding var countryFilter: String
    @Binding var sizeFilter: Int
    @Binding var priceFilter: Int
    
    let resorts = Bundle.main.decode([Resort].self, from: "resorts.json")
    
    var countries: [String] {
        Set(resorts.map { $0.country }).sorted()
    }
    
    var prices: [Int] {
        Set(resorts.map { $0.price }).sorted()
    }
    
    var sizes: [Int] {
        Set(resorts.map { $0.size }).sorted()
    }
    
    func formatSize(_ size: Int) -> String {
        switch size {
        case 1:
            return "Small"
        case 2:
            return "Average"
        default:
            return "Large"
        }
    }
    
    func formatPrice(_ price: Int) -> String {
        String(repeating: "$", count: price)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sorting")) {
                    Picker(selection: $sortingOption, label: Text("Sort by")) {
                        ForEach(SortingOptions.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Filtering")) {
                    Toggle("Only favorites", isOn: $favoriteFilter)
                    
                    Picker(selection: $countryFilter, label: Text("Country")) {
                        Text("All").tag("")
                        ForEach(countries, id: \.self) {
                            Text($0).tag($0)
                        }
                    }
                    
                    Picker(selection: $sizeFilter, label: Text("Size")) {
                        Text("All").tag(0)
                        ForEach(sizes, id: \.self) {
                            Text(self.formatSize($0)).tag($0)
                        }
                    }
                    
                    Picker(selection: $priceFilter, label: Text("Price")) {
                        Text("All").tag(0)
                        ForEach(sizes, id: \.self) {
                            Text(self.formatPrice($0)).tag($0)
                        }
                    }
                }
            }
            .navigationBarTitle("Options")
            .navigationBarItems(trailing: Button("Done") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
