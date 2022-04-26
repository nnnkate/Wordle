//
//  DeleteButtonView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

class DeleteButtonView: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Initial View Setup
    
    private func setUpView() {
        updateView()
        
        setCornerRadius()
        addConstrains()
        
        addButtonTapAction()
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = 4
    }
    
    private func addConstrains() {
        self.translatesAutoresizingMaskIntoConstraints = false

        let multiplier = 1.3

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier)
        ])
    }
    
    // MARK: - Manipulation
    
    private func addButtonTapAction() {
        self.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleButtonTap() {
        print("Delete")
        print(self.currentImage as Any)
    }
    
    // MARK: - View Update
     
    private func updateView() {
        updateBackground()
    }

    private func updateBackground() {
        self.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
        self.backgroundColor = .white
        self.tintColor = .darkGray
    }
}
