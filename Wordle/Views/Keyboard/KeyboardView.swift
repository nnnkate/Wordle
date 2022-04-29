//
//  KeyboardView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

final class KeyboardView: UIStackView {
    var keyboardLetters: [[LetterBox]]
    
    weak var delegate: GameViewController?
    
    init(keyboardLetters: [[LetterBox]]) {
        self.keyboardLetters = keyboardLetters
        
        super.init(frame: .zero)
        
        self.setUpView()
    }
    
    required init(coder: NSCoder) {
        self.keyboardLetters = []
        
        super.init(coder: coder)
        
        self.setUpView()
    }
    
    private func setUpView() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 5
        
        createKeyboard()
    }
    
    private func createKeyboard() {
        for (index, row) in keyboardLetters.enumerated() {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 5
            
            self.addArrangedSubview(stackView)
            
            for box in row {
                let characterKeyboardBoxView = CharacterKeyboardButtonView(keyboardButton: box)
                characterKeyboardBoxView.delegate = delegate
                
                stackView.addArrangedSubview(characterKeyboardBoxView)
            }
            if index == keyboardLetters.count - 1 {
                let deleteKeyboardButtonView = DeleteKeyboardButtonView()
                deleteKeyboardButtonView.delegate = delegate
                stackView.addArrangedSubview(deleteKeyboardButtonView)
            }
        }
    }
    
    func updateKeyboardButtons(_ keyboardLetters: [[LetterBox]]) {
        self.keyboardLetters = keyboardLetters
        
        createKeyboard()
    }
}
