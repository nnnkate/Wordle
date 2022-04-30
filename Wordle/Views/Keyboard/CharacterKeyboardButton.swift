//
//  CharacterKeyboardButton.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

final class CharacterKeyboardButtonView: BaseKeyboardButtonView {
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
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    // MARK: - Manipulation
    
    @objc override func handleButtonTap() {
        delegate?.characterButtonTap(keyboardButton)
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
