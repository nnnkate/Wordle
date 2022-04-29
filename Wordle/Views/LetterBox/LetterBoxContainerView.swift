//
//  LetterBoxContainerView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 29.04.22.
//

import UIKit

final class LetterBoxContainerView: UIStackView {
    init() {
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpView() {
        self.axis = .horizontal
        self.distribution = .fillEqually
        self.spacing = 5
    }
}
