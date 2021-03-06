//
//  GameDelegate.swift
//  Wordle
//
//  Created by Екатерина Неделько on 20.05.22.
//

protocol GameDelegate: AnyObject {
    func handleGameEnd(_ gameStatus: GameStatus)
    
    func updateTimer(_ timerCounter: Int)
}
