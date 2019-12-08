//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Emilio Schepis on 13/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var observed: ObservableOrder
    @State private var errorMessage = ""
    @State private var confirmationMessage = ""
    @State private var showingError = false
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image(decorative: "cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.observed.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place order") {
                        self.placeOrder()
                    }
                    .padding()
                    .alert(isPresented: self.$showingError) {
                        Alert(title: Text("Networking error"), message: Text(self.errorMessage), dismissButton: .default(Text("OK")))
                    }
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(observed.order) else {
            print("Failed to encode order.")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                self.errorMessage = "There was a problem with your request. You will not be charged. Please try again later."
                self.showingError = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(ObservableOrder.Order.self, from: data) {
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(ObservableOrder.Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response.")
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(observed: ObservableOrder())
    }
}
