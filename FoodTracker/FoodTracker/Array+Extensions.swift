//
//  Array+Extensions.swift
//  FoodTracker
//
//  Created by Jens Utbult on 2020-02-12.
//  Copyright © 2020 Apple Inc. All rights reserved.
//

import Foundation

extension Array where Element : Codable {

    private static func documentUrl(for fileName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return url.appendingPathComponent(fileName, isDirectory: false)
    }

    func save(to fileName: String) throws {
        guard let url = [Element].self.documentUrl(for: fileName) else { throw("Failed to create path to \(fileName)!") }
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        if FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
        FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
    }

    static func restore(from fileName: String) throws -> [Element] {
        guard let url = documentUrl(for: fileName) else { fatalError() }
        if let data = FileManager.default.contents(atPath: url.path) {
            let decoder = JSONDecoder()
            let model = try decoder.decode([Element].self, from: data)
            return model
        } else {
            throw("No data at \(url.path)!")
        }
    }
}
