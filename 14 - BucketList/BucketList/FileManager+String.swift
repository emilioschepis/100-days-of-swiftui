//
//  FileManager+String.swift
//  BucketList
//
//  Created by Emilio Schepis on 06/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import Foundation

extension FileManager {
    private var documentsDirectory: URL? {
        urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func writeString(_ content: String, to filePath: String, completion: ((Error?) -> Void)? = nil) {
        guard let documentsDirectory = documentsDirectory else { return }
        
        let url = documentsDirectory.appendingPathComponent(filePath)
        
        do {
            try content.write(to: url, atomically: true, encoding: .utf8)
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
    
    func readString(from filePath: String, completion: (String?, Error?) -> Void) {
        guard let documentsDirectory = documentsDirectory else { return }
        
        let url = documentsDirectory.appendingPathComponent(filePath)
        
        do {
            let content = try String(contentsOf: url)
            completion(content, nil)
        } catch {
            completion(nil, error)
        }
    }
}
