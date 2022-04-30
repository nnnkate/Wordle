//
//  LetterBox.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

typealias Word = [LetterBox]

struct LetterBox {
    var letter: String
    var status: Evaluation?
}

extension Word {
    func notAllowed(in gameManager: GameManager) -> Bool {
        !gameManager.getAllowedWords().contains(self.reduce("") { $0 + $1.letter })
    }
}
