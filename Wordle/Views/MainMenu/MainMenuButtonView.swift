//
//  MainMenuButtonView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 13.05.22.
//

import UIKit

class MainMenuButtonView: UIButton {

    init() {
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpView()
    }
    
    private func setUpView() {
        setCornerRadius()
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = self.frame.height / 5
    }
}
