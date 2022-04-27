//
//  UIView+Extension.swift
//  Wordle
//
//  Created by Екатерина Неделько on 26.04.22.
//

import UIKit

extension UIView {
    func setBorder(color: UIColor = .white) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 3
    }
    func setCornerRadius(cornerRadius: CGFloat = 4) {
        self.layer.cornerRadius = cornerRadius
    }
}
