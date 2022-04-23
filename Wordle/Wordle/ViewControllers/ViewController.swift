//
//  ViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var wordsContainer: UIStackView!
    
    let gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCells()
    }
    
    private func addCells() {
        for _ in 0..<gameManager.lettersCount {
            let lettersContainer = UIStackView()
            
            lettersContainer.axis = .horizontal
            lettersContainer.distribution = .fillProportionally
            lettersContainer.spacing = 5
            lettersContainer.translatesAutoresizingMaskIntoConstraints = false

            wordsContainer.addArrangedSubview(lettersContainer)
            for _ in 0..<gameManager.lettersCount {
                let letterBoxView = LetterBoxView()
                
                letterBoxView.translatesAutoresizingMaskIntoConstraints = false
            
                lettersContainer.addArrangedSubview(letterBoxView)
            }
        }
    }
    
}

