//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Emilio Schepis on 12/11/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

class User: Codable, ObservableObject {
    @Published var name = "Emilio Schepis"
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct ContentView: View {
    @State private var results = [Result]()
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search", text: $searchText, onCommit: {
                            self.loadData(for: self.searchText)
                        }).foregroundColor(.primary)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10.0)
                }
                .padding(.horizontal)
                
                List(results, id: \.trackId) { track in
                    VStack(alignment: .leading) {
                        Text(track.trackName)
                            .font(.headline)
                        Text(track.collectionName)
                    }
                }
            }
            .navigationBarTitle("Songs")
        }
        .onAppear(perform: {
            self.loadData()
        })
    }
    
    func loadData(for artist: String = "Taylor Swift") {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "itunes.apple.com"
        components.path = "/search"
        components.queryItems = [
            URLQueryItem(name: "term", value: artist),
            URLQueryItem(name: "entity", value: "song")
        ]
        
        guard let url = components.url else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let dataResponse = try? JSONDecoder().decode(Response.self, from: data) {
                DispatchQueue.main.async {
                    self.results = dataResponse.results
                }
                
                return
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
