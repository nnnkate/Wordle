//
//  WordContainerView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 30.04.22.
//

import UIKit

final class WordContainerView: UIStackView {
    init() {
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpView() {
        self.axis = .vertical
        self.distribution = .fillEqually
        self.spacing = 5
    }
    
    func addArrangedSubview(_ view: LetterBoxContainerView) {
        super.addArrangedSubview(view)
        
        // work whith gameManager -> gameLetters ???
    }
}

