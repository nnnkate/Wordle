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
        didSet {
            updateData()
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
    
    func updateData() {
        guard let letterBox = letterBox  else {
            letterLabel.text = ""
            return
        }
        letterLabel.text = String(letterBox.letter)
        
        
        switch letterBox.status {
        case .wrong:
            letterStatusView.backgroundColor = .darkGray
        case .correct:
            letterStatusView.backgroundColor = .green
        case .wrongLocation:
            letterStatusView.backgroundColor = .orange
        default:
            letterStatusView.backgroundColor = .clear
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
