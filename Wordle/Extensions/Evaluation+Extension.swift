//
//  Evaluation+Extension.swift
//  Wordle
//
//  Created by Екатерина Неделько on 29.04.22.
//

import UIKit

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
