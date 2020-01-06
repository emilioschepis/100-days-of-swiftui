//
//  Mission.swift
//  Moonshot
//
//  Created by Emilio Schepis on 03/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var crewNames: String {
        crew.map { $0.name }.joined(separator: ", ")
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
}
