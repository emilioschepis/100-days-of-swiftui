//
//  Order.swift
//  CupcakeCorner
//
//  Created by Emilio Schepis on 13/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

class ObservableOrder: ObservableObject {
    struct Order: Codable {
        static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
        
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if specialRequestEnabled == false {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        var hasValidAddress: Bool {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                || streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                || city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                || zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return false
            }

            return true
        }
        
        var cost: Double {
            // $2 per cake
            var cost = Double(quantity) * 2

            // complicated cakes cost more
            cost += (Double(type) / 2)

            // $1/cake for extra frosting
            if extraFrosting {
                cost += Double(quantity)
            }

            // $0.50/cake for sprinkles
            if addSprinkles {
                cost += Double(quantity) / 2
            }

            return cost
        }
    }
    
    @Published var order = Order()
}
