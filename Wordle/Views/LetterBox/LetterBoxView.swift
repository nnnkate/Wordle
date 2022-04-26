//
//  LetterBoxView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

import UIKit

class LetterBoxView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var letterLabel: UILabel!
    
    private var letterBox: LetterBox? {
        didSet {
            updateView()
        }
    }
    
    init(letterBox: LetterBox) {
        super.init(frame: .zero)
        
        self.letterBox = letterBox
        
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpView()
    }
    
    private func setUpView() {
        createXib()
        contentView.setBorder()
        
        updateView()
    }
    
    private func createXib() {
        Bundle.main.loadNibNamed("LetterBoxView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - View Update
    
    func updateLetterBox(letterBox: LetterBox?) {
        self.letterBox = letterBox
    }
     
    private func updateView() {
        updateLabel(letter: letterBox?.letter)
        updateBackground(status: letterBox?.status)
    }

    private func updateLabel(letter: String?) {
        letterLabel.text = letter?.uppercased()
    }

    private func updateBackground(status: Evaluation?) {
        contentView.backgroundColor = status?.backgroundColor ?? .clear
    }
    
}

extension Evaluation {
    var backgroundColor: UIColor {
        switch self {
        case .wrong:
            return .darkGray
            
        case .wrongLocation:
            return .orange
            
        case .correct:
            return .green
        }
    }
    
    var fontColor: UIColor {
        .white
    }
}

extension Optional where Wrapped == Evaluation {
    var backgroundColor: UIColor {
        self?.backgroundColor ?? .clear
    }
    
    var fontColor: UIColor {
        self?.backgroundColor ?? .darkGray
    }
}
