//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Emilio Schepis on 05/01/2020.
//  Copyright © 2020 Emilio Schepis. All rights reserved.
//

import SwiftUI

enum SortingOptions: String, CaseIterable {
    case `default` = "Default"
    case alphabetical = "Alphabetically"
    case country = "By country"
}

struct ContentView: View {
    @ObservedObject var favorites = Favorites()
    @State private var sortingOption = SortingOptions.default
    @State private var favoriteFilter = false
    @State private var countryFilter = ""
    @State private var sizeFilter = 0
    @State private var priceFilter = 0
    @State private var showingOptionsSheet = false
    
    let resorts = Bundle.main.decode([Resort].self, from: "resorts.json")
    
    var optionsButton: some View {
        Button(action: {
            self.showingOptionsSheet = true
        }) {
            Image(systemName: "wand.and.rays")
        }
        .sheet(isPresented: $showingOptionsSheet) {
            OptionsView(sortingOption: self.$sortingOption,
                        favoriteFilter: self.$favoriteFilter,
                        countryFilter: self.$countryFilter,
                        sizeFilter: self.$sizeFilter,
                        priceFilter: self.$priceFilter)
        }
    }
    
    var filteredResorts: [Resort] {
        var filteredResorts = self.resorts
                
        if favoriteFilter == true {
            filteredResorts = filteredResorts.filter { self.favorites.contains($0) }
        }
        
        switch countryFilter {
        case "":
            break
        default:
            filteredResorts = filteredResorts.filter { $0.country.lowercased() == countryFilter.lowercased() }
        }
        
        switch sizeFilter {
        case 1, 2, 3:
            filteredResorts = filteredResorts.filter { $0.size == sizeFilter }
        default:
            break
        }
        
        switch priceFilter {
        case 1, 2, 3:
            filteredResorts = filteredResorts.filter { $0.price == priceFilter }
        default:
            break
        }
        
        return filteredResorts
    }
    
    var sortedResorts: [Resort] {
        switch sortingOption {
        case .default:
            return filteredResorts
        case .alphabetical:
            return filteredResorts.sorted(by: { $0.name < $1.name })
        case .country:
            return filteredResorts.sorted(by: { $0.country < $1.country })
        }
    }
    
    var body: some View {
        NavigationView {
            List(sortedResorts) { resort in
                NavigationLink(destination: ResortView(resort: resort)) {
                    Image(resort.country)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 25)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 5)
                    )
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 1)
                    )
                    
                    VStack(alignment: .leading) {
                        Text(resort.name)
                            .font(.headline)
                        Text("\(resort.runs) runs")
                            .foregroundColor(.secondary)
                    }
                    .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .navigationBarItems(trailing: optionsButton)
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
