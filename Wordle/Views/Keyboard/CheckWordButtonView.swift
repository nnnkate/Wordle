//
//  CheckWordButtonView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 28.04.22.
//

import UIKit

final class CheckWordButtonView: BaseKeyboardButtonView {
    
    private var checkStatus: CheckButtonStatus = .inactive {
        didSet {
            updateBackground(status: nil)
        }
    }
    
    override func setUpView() {
        super.setUpView()
        
        setTitleCharacteristics()
    }
    
    @objc override func handleButtonTap() {
        if self.checkStatus == .notAWord {
            return
        }
        
        delegate?.handleButtonTap(type: .enter)
    }
    
    override func updateBackground(status: Evaluation?) {
        self.backgroundColor = checkStatus.backgroundColor
        
        self.setTitle(checkStatus.title, for: .normal)
    }
    
    private func setTitleCharacteristics() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.tintColor = .white
    }
    
    private func setCheckButtonStatus(_ checkStatus: CheckButtonStatus){
        self.checkStatus = checkStatus
    }
    
    func updateStatus(gameManager: GameManager) {
        let enteredWord: Word = gameManager.getEnteredWord()
        if enteredWord.count < gameManager.lettersCount {
            self.setCheckButtonStatus(.inactive)
        } else if enteredWord.notAllowed(in: gameManager) {
            self.setCheckButtonStatus(.notAWord)
        } else {
            self.setCheckButtonStatus(.active)
        }
    }
    
}


