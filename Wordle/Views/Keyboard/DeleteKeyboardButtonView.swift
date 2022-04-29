//
//  DeleteKeyboardButtonView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

final class DeleteKeyboardButtonView: BaseKeyboardButtonView {
    
    override func setUpView() {
        super.setUpView()
        
        addConstrains(multiplier: 0.5)
    }
    
    @objc override func handleButtonTap() {
        delegate?.deleteButtonTap()
    }
    
    override func updateBackground(status: Evaluation?) {
        super.updateBackground(status: status)
        
        self.setImage(UIImage(systemName: "delete.left.fill"), for: .normal)
    }
}
