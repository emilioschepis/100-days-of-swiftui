//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Emilio Schepis on 01/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
