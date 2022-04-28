//
//  BaseKeyboardButton.swift
//  Wordle
//
//  Created by Екатерина Неделько on 28.04.22.
//

import UIKit

class BaseKeyboardButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Initial View Setup
    
    func setUpView() {
        updateView()
        
        setCornerRadius()
        addButtonTapAction()
    }
    
    func addConstrains(multiplier: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier)
        ])
    }
    
    // MARK: - Manipulation
    
    private func addButtonTapAction() {
        self.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc func handleButtonTap() {
        print("Button \(self.titleLabel?.text ?? "Base")")
    }
    
    // MARK: - View Update
     
    func updateView() {
        updateBackground(status: nil)
    }

    func updateBackground(status: Evaluation?) {
        self.backgroundColor = .white
        self.tintColor = .darkGray
    }
}