//
//  ContentView.swift
//  BucketList
//
//  Created by Emilio Schepis on 06/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import LocalAuthentication
import MapKit

enum BiometricError: Error {
    case notAvailable, notRecognized, unknown
}

struct ContentView: View {
    @State private var isUnlocked = false
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var showingBiometricError = false
    @State private var biometricError = BiometricError.unknown
    
    var body: some View {
        ZStack {
            if isUnlocked {
                UnlockedView(centerCoordinate: $centerCoordinate,
                             locations: $locations,
                             selectedPlace: $selectedPlace,
                             showingPlaceDetails: $showingPlaceDetails,
                             showingEditScreen: $showingEditScreen)
            } else {
                Button(action: self.authenticate) {
                    VStack {
                        Image(systemName: "lock.fill")
                        Text("Unlock places with FaceID")
                    }
                }
                .alert(isPresented: $showingBiometricError) {
                    let errorMessage: String
                    
                    switch biometricError {
                    case .notAvailable:
                        errorMessage = "Biometric security is not available."
                    case .notRecognized:
                        errorMessage = "Sorry, FaceID could not recognize you."
                    case .unknown:
                        errorMessage = "Unknown biometric error."
                    }
                    
                    return Alert(title: Text("Biometric error"), message: Text(errorMessage), dismissButton: .cancel())
                }
                
            }
        }
        .onAppear(perform: {
            self.loadData()
            self.authenticate()
        })
        .alert(isPresented: $showingPlaceDetails) {
            Alert(title: Text(selectedPlace?.title ?? "Unknown"),
                  message: Text(selectedPlace?.subtitle ?? "Missing place information."),
                  primaryButton: .default(Text("OK")),
                  secondaryButton: .default(Text("Edit")) {
                    self.showingEditScreen = true
            })
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData) {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.biometricError = .notRecognized
                        self.showingBiometricError = true
                    }
                }
            }
        } else {
            self.biometricError = .notAvailable
            self.showingBiometricError = true
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadData() {
        let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: fileName)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }
    }
    
    func saveData() {
        do {
            let fileName = getDocumentsDirectory().appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            try data.write(to: fileName, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
