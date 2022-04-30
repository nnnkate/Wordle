//
//  CheckButtonStatus+Extension.swift
//  Wordle
//
//  Created by Екатерина Неделько on 29.04.22.
//

import UIKit

extension CheckButtonStatus {
    var backgroundColor: UIColor {
        switch self {
        case .notAWord:
            return .red
            
        case .inactive:
            return .gray
            
        case .active:
            return .blue
        }
    }
    
    var title: String {
        switch self {
        case .notAWord:
            return "NOT A WORD"
            
        default:
            return "SUBMIT"
        }
    }
}
