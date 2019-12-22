//
//  Prospects.swift
//  HotProspects
//
//  Created by Emilio Schepis on 22/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
}
