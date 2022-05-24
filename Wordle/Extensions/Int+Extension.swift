//
//  Int+Extension.swift
//  Wordle
//
//  Created by Екатерина Неделько on 24.05.22.
//

import Foundation

extension Int {
    func getTimerString() -> String {
        var timerCounter = self
        let hours = Swift.max(timerCounter / 360, 0)
        timerCounter -= (hours * 360)
        let minutes = Swift.max(timerCounter / 60, 0)
        timerCounter -= minutes * 60
        
        return String("\(hours):\(String(format: "%02d", minutes)):\(String(format: "%02d", timerCounter))")
    }
}
