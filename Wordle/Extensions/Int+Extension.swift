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
        let hours = timerCounter / 360
        timerCounter -= (hours * 360)
        let minutes = timerCounter / 60
        timerCounter -= minutes * 60
        
        return "\(hours):\(String(format: "%02d", minutes)):\(String(format: "%02d", timerCounter))"
    }
}
