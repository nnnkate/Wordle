//
//  KeyboardManager.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

struct KeyboardManager {
    let keyboardLetters: [[LetterBox]]
    
    init() {
        let letters = [
            ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
            ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
            ["Z", "X", "C", "V", "B", "N", "M"]
        ]
        
        self.keyboardLetters = letters.map { $0.map { LetterBox(letter: $0) } }
    }
}
