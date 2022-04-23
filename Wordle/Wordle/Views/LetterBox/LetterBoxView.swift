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
    
//    func updateData(letterBox: LetterBox) {
//        letterLabel.text = String(letterBox.letter)
//    }
    
    private func setUpView() {
        createXib()
        
//        if let header = header {
//            updateData(header: header)
//        }
    }
    
    private func createXib() {
        Bundle.main.loadNibNamed("LetterBoxView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
