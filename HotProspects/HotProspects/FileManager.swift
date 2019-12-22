//
//  FileManager.swift
//  HotProspects
//
//  Created by Emilio Schepis on 22/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

enum FileError: Error {
    case badData
}

extension FileManager {
    private var documentsDirectory: URL? {
        urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func save<T: Codable>(_ data: T, to filePath: String, completion: ((Error?) -> Void)? = nil) {
        guard let documentsDirectory = documentsDirectory else { return }
        
        let url = documentsDirectory.appendingPathComponent(filePath)
        
        guard let encodedData = try? JSONEncoder().encode(data) else {
            completion?(FileError.badData)
            return
        }
        
        do {
            try encodedData.write(to: url, options: [.atomic, .completeFileProtection])
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
    
    func load<T: Codable>(from filePath: String, completion: (Result<T, Error>) -> Void) {
        guard let documentsDirectory = documentsDirectory else { return }
                
        let url = documentsDirectory.appendingPathComponent(filePath)
        
        guard let data = try? Data(contentsOf: url) else {
            completion(.failure(FileError.badData))
            return
        }
        
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            completion(.failure(FileError.badData))
            return
        }
        
        completion(.success(decodedData))
    }
}
