//
//  FileManager+UIImage.swift
//  MeetUI
//
//  Created by Emilio Schepis on 09/12/2019.
//  Copyright © 2019 Emilio Schepis. All rights reserved.
//

import SwiftUI

enum FileError: Error {
    case empty
}

extension FileManager {
    private var documentsDirectory: URL? {
        urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    func saveImage(_ image: UIImage, to filePath: String, completion: ((Error?) -> Void)? = nil) {
        guard let documentsDirectory = documentsDirectory else { return }
        
        let url = documentsDirectory.appendingPathComponent(filePath)
        
        guard let imageData = image.pngData() else {
            completion?(FileError.empty)
            return
        }
        
        do {
            try imageData.write(to: url, options: [.atomic, .completeFileProtection])
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
    
    func readImage(from filePath: String, completion: (UIImage?, Error?) -> Void) {
        guard let documentsDirectory = documentsDirectory else { return }
        
        let url = documentsDirectory.appendingPathComponent(filePath)
        
        let image = UIImage(contentsOfFile: url.path)
        completion(image, nil)
    }
    
    func deleteImage(at filePath: String, completion: ((Error?) -> Void)? = nil) {
        guard let documentsDirectory = documentsDirectory else { return }
        
        let url = documentsDirectory.appendingPathComponent(filePath)
        
        do {
            try removeItem(at: url)
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
}
