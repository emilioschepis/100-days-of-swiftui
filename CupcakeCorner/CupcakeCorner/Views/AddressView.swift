//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Emilio Schepis on 13/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var observed: ObservableOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $observed.order.name)
                TextField("Street address", text: $observed.order.streetAddress)
                TextField("City", text: $observed.order.city)
                TextField("Zip", text: $observed.order.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(observed: observed)) {
                    Text("Checkout")
                }
            }
            .disabled(observed.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(observed: ObservableOrder())
    }
}
