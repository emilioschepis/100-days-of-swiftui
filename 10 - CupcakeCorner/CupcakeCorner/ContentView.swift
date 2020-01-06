//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Emilio Schepis on 12/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var observed = ObservableOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $observed.order.type) {
                        ForEach(0..<ObservableOrder.Order.types.count, id: \.self) {
                            Text(ObservableOrder.Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $observed.order.quantity, in: 3...20) {
                        Text("Number of cakes: \(observed.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $observed.order.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if observed.order.specialRequestEnabled {
                        Toggle(isOn: $observed.order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $observed.order.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(observed: observed)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("CupcakeCorner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
