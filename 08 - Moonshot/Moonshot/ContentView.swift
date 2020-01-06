//
//  ContentView.swift
//  Moonshot
//
//  Created by Emilio Schepis on 03/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showingLaunchDate = true
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.showingLaunchDate ? mission.formattedLaunchDate : mission.crewNames)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: self.showingLaunchDate
                        ? Text("\(mission.displayName), launched on: \(mission.formattedLaunchDate)")
                        : Text("\(mission.displayName), crew: \(mission.crewNames)"))
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button("Switch view") {
                self.showingLaunchDate.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
