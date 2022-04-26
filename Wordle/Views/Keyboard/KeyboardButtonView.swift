//
//  KeyboardButtonView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

class KeyboardButtonView: UIButton {
    private var keyboardButton: LetterBox! {
        didSet {
            updateView()
        }
    }
    
    init(keyboardButton: LetterBox) {
        self.keyboardButton = keyboardButton
        
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Initial View Setup
    
    private func setUpView() {
        updateView()
        
        setTitleFont()
        setCornerRadius()
        addConstrains()
        
        addButtonTapAction()
    }
    
    private func setTitleFont() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = 4
    }
    
    private func addConstrains() {
        self.translatesAutoresizingMaskIntoConstraints = false

        let multiplier = 0.5

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier)
        ])
    }
    
    // MARK: - Manipulation
    
    private func addButtonTapAction() {
        self.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleButtonTap() {
        print(keyboardButton.letter)
    }
    
    // MARK: - View Update
    
    func updateKeyboardButton(keyboardButton: LetterBox?) {
        self.keyboardButton = keyboardButton
    }
     
    private func updateView() {
        updateLabel(letter: keyboardButton.letter)
        updateBackground(status: keyboardButton?.status)
    }
    
    private func updateLabel(letter: String) {
        updateTitle(with: letter)
    }

    private func updateTitle(with text: String) {
        setTitle(text, for: .normal)
    }

    private func updateBackground(status: Evaluation?) {
        self.backgroundColor = status?.backgroundColor ?? .white
        self.setTitleColor(status?.fontColor ?? .darkGray, for: .normal)
    }
    
}
