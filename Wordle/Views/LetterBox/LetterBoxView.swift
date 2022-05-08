//
//  LetterBoxView.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

import UIKit

final class LetterBoxView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var letterLabel: UILabel!
    
    private (set) var letterBox: LetterBox? {
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
        contentView.setCornerRadius()
        
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
        updateLabel(letter: letterBox?.letter, status: letterBox?.status)
        updateBackground(status: letterBox?.status)
    }

    private func updateLabel(letter: String?, status: Evaluation?) {
        letterLabel.text = letter?.uppercased()
        letterLabel.textColor = status?.fontColor ?? .darkGray
    }

    private func updateBackground(status: Evaluation?) {
        contentView.backgroundColor = status?.backgroundColor ?? .clear
    }
    
    // MARK: - Get/Set Conditions
    
    func getLetterBoxStatus() -> Evaluation? {
        letterBox?.status
    }
    
    func getLetterBoxLetter() -> String {
        letterBox?.letter ?? ""
    }
    
    func setLetterBoxStatus(_ status: Evaluation){
        letterBox?.setStatus(status)
    }
}

