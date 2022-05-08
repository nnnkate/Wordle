//
//  LetterBox.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

typealias Word = [LetterBox]

struct LetterBox {
    private (set) var letter: String
    private (set) var status: Evaluation?
    
    mutating func setLetter(_ letter: String) {
        self.letter = letter
    }
    
    mutating func setStatus(_ status: Evaluation) {
        self.status = status
    }
}

extension Word {
    func notAllowed(in gameManager: GameManager) -> Bool {
        !gameManager.allowedWords.contains(self.reduce("") { $0 + $1.letter })
    }
}
