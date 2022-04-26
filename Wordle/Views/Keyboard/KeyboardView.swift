//
//  KeyboardView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

class KeyboardView: UIStackView {
    var keyboardLetters: [[LetterBox]]
    
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
            stackView.distribution = .fillProportionally
            stackView.spacing = 5
            
            self.addArrangedSubview(stackView)
            
            for box in row {
                let keyboardBoxView = KeyboardButtonView(keyboardButton: box)
               
                stackView.addArrangedSubview(keyboardBoxView)
            }
            if index == keyboardLetters.count - 1 {
                stackView.addArrangedSubview(DeleteButtonView())
            }
        }
    }
    
    func updateKeyboardButtons(_ keyboardLetters: [[LetterBox]]) {
        self.keyboardLetters = keyboardLetters
        
        createKeyboard()
    }
}
