//
//  GameManager.swift
//  Wordle
//
//  Created by Екатерина Неделько on 23.04.22.
//
import Foundation

class GameManager {
    private (set) var lettersCount = 5
    private (set) var attemptsCount = 6
    
    private (set) var currentWord = ""
    private (set) var allowedWords = Set<String>()
    
    private (set) var gameField = [[LetterBox?]]()
    
    private let fileName = "AllowedWords"
    
    private (set) var gameStatus: GameStatus = .playing
    
    private var lastCheckedRow: Int?
    
    init(lettersCount: Int = 5, attemptsCount: Int = 6) {
        setLettersCount(lettersCount)
        setAttemptsNumber(attemptsCount)
        
        self.gameField = Array(repeating: Array(repeating: nil, count: lettersCount), count: attemptsCount)
        
        fillAllowedWords()
        
        generateRandomWord()
    }
    
    // MARK: - Game Settings
    
    func setLettersCount(_ lettersCount: Int) {
        self.lettersCount = lettersCount
    }
    
    func setAttemptsNumber(_ attemptsCount: Int) {
        self.attemptsCount = attemptsCount
    }
    
    // MARK: - Randow Word
    
    private func generateRandomWord() {
        guard let randomWord = allowedWords.randomElement() else {
            return
        }
        
        self.currentWord = randomWord.uppercased()
    }
    
    // MARK: - Allowed Words
    
    private func fillAllowedWords() {
        let path = readFile()
        
        guard let allowedWordsArray = try? String(contentsOfFile: path, encoding: String.Encoding.utf8).split(separator: "\n") else {
            return }
        
        self.allowedWords = Set(allowedWordsArray.map { $0.uppercased() })
    }

    // MARK: - File Handing
    
    private func readFile() -> String {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return ""
        }
              
        return path
    }
    
    // MARK: - Data processing
    
    func setCellValue(rowIndex: Int, cellIndex: Int, value: LetterBox?) {
        if let value = value {
            gameField[rowIndex][cellIndex] = value
            lastCheckedRow = rowIndex
        }
    }
    
    // MARK: - Game Result
    
    func checkGameStatus() {
        gameField.forEach {
            if $0.reduce(into: true, { if $1?.status != .correct { $0 = false } }) {
                gameStatus = .win
                return
            }
        }
        
        if let lastCheckedRow = lastCheckedRow, lastCheckedRow == attemptsCount - 1 {
            gameStatus = .lost
        }
    }
    
    // TODO: - Check "this word has already been entered"
}
