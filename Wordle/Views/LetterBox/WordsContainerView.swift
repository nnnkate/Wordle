//
//  WordsContainerView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 30.04.22.
//

import UIKit

final class WordsContainerView: UIStackView {
    var gameField: [[LetterBox?]]
    
    private var wordsContainer: [[LetterBoxView]]?
    
    init(gameField: [[LetterBox?]]) {
        self.gameField = gameField
        
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init(coder: NSCoder) {
        self.gameField = []
        
        super.init(coder: coder)
    }
    
    private func setUpView() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 5
    }
    
    private func createField() {
        self.wordsContainer = []

        for row in gameField {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 10

            self.addArrangedSubview(stackView)

            var letterBoxRow = [LetterBoxView]()

            for letter in row {
                let letterBoxView = LetterBoxView(letterBox: letter)

                letterBoxView.translatesAutoresizingMaskIntoConstraints = false

                NSLayoutConstraint.activate([
                    letterBoxView.widthAnchor.constraint(equalTo: letterBoxView.heightAnchor)
                ])

                stackView.addArrangedSubview(letterBoxView)

                letterBoxRow.append(letterBoxView)
            }

            self.wordsContainer?.append(letterBoxRow)
        }
    }
    
    func updateGameField(_ gameField: [[LetterBox?]]) {
        self.gameField = gameField
        
        if wordsContainer == nil || wordsContainer?.isEmpty == true {
            createField()
        }
        
        guard let wordsContainer = wordsContainer else {
            return
        }
        
        for (rowIndex, row) in gameField.enumerated() {
            for (letterIndex, letterBox) in row.enumerated() {
                wordsContainer[rowIndex][letterIndex].updateLetterBox(letterBox: letterBox)
            }
        }
    }
}

