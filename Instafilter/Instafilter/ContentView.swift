//
//  ContentView.swift
//  Instafilter
//
//  Created by Emilio Schepis on 02/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var filterRadius = 0.5
    @State private var filterScale = 0.5
    @State private var showingImagePicker = false
    @State private var showingFilterSheet = false
    @State private var currentFilterName = "Sepia tone"
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    
    @State private var errorMessage = ""
    @State private var showingErrorAlert = false
    
    let context = CIContext()

    var body: some View {
        let intensity = Binding<Double>(get: {
            self.filterIntensity
        }, set: {
            self.filterIntensity = $0
            self.applyProcessing()
        })
        
        let radius = Binding<Double>(get: {
            self.filterRadius
        }, set: {
            self.filterRadius = $0
            self.applyProcessing()
        })
        
        let scale = Binding<Double>(get: {
            self.filterScale
        }, set: {
            self.filterScale = $0
            self.applyProcessing()
        })
        
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    self.showingImagePicker = true
                }
                
                VStack {
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity)
                    }
                    
                    HStack {
                        Text("Radius")
                        Slider(value: radius)
                    }
                    
                    HStack {
                        Text("Scale")
                        Slider(value: scale)
                    }
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter (\(currentFilterName))") {
                        self.showingFilterSheet = true
                    }
                    
                    Spacer ()
                    
                    Button ("Save") {
                        guard let processedImage = self.processedImage else { return }
                        
                        let imageSaver = ImageSaver()
                        
                        imageSaver.successHandler = {
                            print("Saved successfully.")
                        }
                        
                        imageSaver.errorHandler = {
                            self.errorMessage = $0.localizedDescription
                            self.showingErrorAlert = true
                        }
                        
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .navigationBarTitle("Instafilter")
            .padding([.horizontal, .bottom])
            .alert(isPresented: $showingErrorAlert) {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .cancel())
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                    .default(Text("Crystallize")) { self.setFilter(CIFilter.crystallize()) },
                    .default(Text("Edges")) { self.setFilter(CIFilter.edges()) },
                    .default(Text("Gaussian Blur")) { self.setFilter(CIFilter.gaussianBlur()) },
                    .default(Text("Pixellate")) { self.setFilter(CIFilter.pixellate()) },
                    .default(Text("Sepia Tone")) { self.setFilter(CIFilter.sepiaTone()) },
                    .default(Text("Unsharp Mask")) { self.setFilter(CIFilter.unsharpMask()) },
                    .default(Text("Vignette")) { self.setFilter(CIFilter.vignette()) },
                    .cancel()
                ])
            }
        }
    }
    
    func loadImage() {
        currentFilterName = currentFilter.name
        
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterRadius * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterScale * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImage)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
