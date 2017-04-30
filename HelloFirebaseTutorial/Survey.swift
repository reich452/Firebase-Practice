//
//  Survey.swift
//  HelloFirebaseTutorial
//
//  Created by Nick Reichard on 4/30/17.
//  Copyright © 2017 Nick Reichard. All rights reserved.
//

import Foundation

class Survey {
    private let nameKey = "name"
    private let favoriteEmojiKey = "favoriteEmoji"
    private let uidKey = "uid"
    
    let name: String
    let favoriteEmoji: String
    let uid: UUID
    
    init?(dictionary: [String: String], identifier: String) {
        guard let name = dictionary[nameKey],
        let favoriteEmoji = dictionary[favoriteEmojiKey],
            let uuid = UUID(uuidString: identifier) else { return nil }
        
        self.name = name
        self.favoriteEmoji = favoriteEmoji
        self.uid = uuid
    }
    
    init(name: String, favoriteEmoji: String, uid: UUID = UUID()) {
        self.name = name
        self.favoriteEmoji = favoriteEmoji
        self.uid = uid
    }
    
    var dictionaryRepresentation: [String: String] {
        return [nameKey: name, favoriteEmojiKey: favoriteEmoji, uidKey: uid.uuidString]
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
}
