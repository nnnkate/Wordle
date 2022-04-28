//
//  CharacterKeyboardButton.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

final class CharacterKeyboardButtonView: BaseKeyboardButton {
    private var keyboardButton: LetterBox! {
        didSet {
            updateView()
        }
    }
    
    init(keyboardButton: LetterBox) {
        self.keyboardButton = keyboardButton
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Initial View Setup
    
    override func setUpView() {
        super.setUpView()
        
        setTitleFont()
        self.addConstrains(multiplier: 0.5)
    }
    
    private func setTitleFont() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    // MARK: - Manipulation
    
    @objc override func handleButtonTap() {
        print(keyboardButton.letter)
    }
    
    // MARK: - View Update
    
    func updateKeyboardButton(keyboardButton: LetterBox?) {
        self.keyboardButton = keyboardButton
    }
     
    override func updateView() {
        super.updateView()
        
        updateLabel(letter: keyboardButton.letter)
    }
    
    private func updateLabel(letter: String) {
        updateTitle(with: letter)
    }

    private func updateTitle(with text: String) {
        setTitle(text, for: .normal)
    }

    override func updateBackground(status: Evaluation?) {
        self.backgroundColor = status?.backgroundColor ?? .white
        self.setTitleColor(status?.fontColor ?? .darkGray, for: .normal)
    }
    
}