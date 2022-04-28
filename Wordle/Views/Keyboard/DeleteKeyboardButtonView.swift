//
//  DeleteKeyboardButtonView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

class DeleteKeyboardButtonView: BaseKeyboardButton {
    
    override func setUpView() {
        super.setUpView()
        
        addConstrains(multiplier: 0.5)
    }
    
    @objc override func handleButtonTap() {
        print("Delete")
    }
    
    override func updateBackground(status: Evaluation?) {
        super.updateBackground(status: status)
        
        self.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
    }
}
