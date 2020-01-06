//
//  MissionView.swift
//  Moonshot
//
//  Created by Emilio Schepis on 04/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader { fullScreen in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(decorative: self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(max(0.8, min(1.0, geo.frame(in: .global).minY / (fullScreen.size.height / 10))))
                            .frame(width: geo.size.width)
                    }
                    .frame(height: 300)
                    
                    Text(self.mission.formattedLaunchDate)
                        .fontWeight(.bold)
                    Text(self.mission.description)
                        .layoutPriority(1)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                CrewMemberView(astronaut: crewMember.astronaut, role: crewMember.role)
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
