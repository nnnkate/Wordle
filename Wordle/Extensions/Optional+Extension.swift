//
//  Optional+Extension.swift
//  Wordle
//
//  Created by Екатерина Неделько on 29.04.22.
//

import UIKit

extension Optional where Wrapped == Evaluation {
    var backgroundColor: UIColor {
        self?.backgroundColor ?? .clear
    }
    
    var fontColor: UIColor {
        self?.fontColor ?? .darkGray
    }
}

