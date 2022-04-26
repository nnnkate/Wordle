//
//  ViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordsContainer: UIStackView!
    @IBOutlet weak var keyboardContainer: KeyboardView!
    
    private let gameManager = GameManager()
    private let keyboardManager = KeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCells()
        keyboardContainer.updateKeyboardButtons(keyboardManager.keyboardLetters)
    }
    
    private func addCells() {
        for _ in 0..<gameManager.lettersCount {
            let lettersContainer = UIStackView()
            
            lettersContainer.axis = .horizontal
            lettersContainer.distribution = .fillProportionally
            lettersContainer.spacing = 5
            
            wordsContainer.addArrangedSubview(lettersContainer)
            for _ in 0..<gameManager.attemptsNumber {
                let letterBoxView = LetterBoxView()
                
                letterBoxView.translatesAutoresizingMaskIntoConstraints = false
                letterBoxView.widthAnchor.constraint(equalTo: letterBoxView.heightAnchor).isActive = true
                
                lettersContainer.addArrangedSubview(letterBoxView)
            }
        }
    }
    
}

