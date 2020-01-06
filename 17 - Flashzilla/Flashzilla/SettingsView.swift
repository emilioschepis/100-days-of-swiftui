//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Emilio Schepis on 25/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var retry: Bool
    
    var body: some View {
        NavigationView {
            Form {
                Toggle(isOn: $retry) {
                    Text("Retry cards")
                }
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(retry: .constant(false))
    }
}
