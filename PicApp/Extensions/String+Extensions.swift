//
//  String+Extensions.swift
//  PicApp
//
//  Created by Negin Zahedi on 2024-06-14.
//

import Foundation

extension String {
    func capitalizedEachWord() -> String {
        let words = self.components(separatedBy: " ")
        let capitalizedWords = words.map { word -> String in
            guard let firstChar = word.first else { return "" }
            return word.replacingCharacters(in: ..<word.index(after: startIndex), with: String(firstChar).capitalized)
        }
        return capitalizedWords.joined(separator: " ")
    }
}
