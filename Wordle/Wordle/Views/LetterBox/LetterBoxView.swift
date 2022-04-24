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
    
    @IBOutlet weak var letterStatusView: UIView!
    
    var letterBox: LetterBox? {
        get {
            return self.letterBox
        }
        set {
            guard let newValue = newValue, let newValueLetter = newValue.letter  else {
                letterLabel.text = ""
                return
            }
            letterLabel.text = String(newValueLetter)
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
    
    func updateData(letterBox: LetterBox) {
        self.letterBox = letterBox
        
        switch letterBox.status {
        case .wrong:
            letterStatusView.backgroundColor = .darkGray
        case .correct:
            letterStatusView.backgroundColor = .green
        case .wrongLocation:
            letterStatusView.backgroundColor = .orange
        }
    }
    
    private func setUpView() {
        createXib()
        
        //add functionality
    }
    
    private func createXib() {
        Bundle.main.loadNibNamed("LetterBoxView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
