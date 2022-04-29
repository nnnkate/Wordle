//
//  CheckWordButtonView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 28.04.22.
//

import UIKit

final class CheckWordButtonView: BaseKeyboardButtonView {
    
    override func setUpView() {
        super.setUpView()
    }
    
    @objc override func handleButtonTap() {
        delegate?.checkWordButtonTap()
    }
    
    override func updateBackground(status: Evaluation?) {
        super.updateBackground(status: status)
        //self.backgroundColor = .red
        
        self.setImage(UIImage(systemName: "infinity"), for: .normal)
    }
}
