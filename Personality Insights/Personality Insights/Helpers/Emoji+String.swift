//
//  Emoji+String.swift
//  Personality Insights
//
//  Created by Piera Marchesini on 26/09/18.
//  Copyright © 2018 Piera Marchesini. All rights reserved.
//

import Foundation

extension String {
    func stringByRemovingEmoji() -> String {
        return String(self.filter { !$0.isEmoji() })
    }
}

extension Character {
    fileprivate func isEmoji() -> Bool {
        return Character(UnicodeScalar(UInt32(0x1d000))!) <= self && self <= Character(UnicodeScalar(UInt32(0x1f77f))!)
            || Character(UnicodeScalar(UInt32(0x2100))!) <= self && self <= Character(UnicodeScalar(UInt32(0x26ff))!)
    }
    
    fileprivate func isHashtag() -> Bool {
        return self == "#"
    }
}

extension String {
    func stringByRemovingHashtag() -> String {
        return String(self.filter { !$0.isHashtag() })
    }
}
