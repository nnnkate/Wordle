//
//  GameManager.swift
//  Wordle
//
//  Created by Екатерина Неделько on 23.04.22.
//
import Foundation

struct GameManager {
    private var lettersCount = 5
    private var attemptsNumber = 5
    
    private var currentWord = ""
    private var allowedWords = Set<Substring>()
    
    private var gameLetters = [[LetterBox?]]()
    
    private let fileName = "AllowedWords"
    
    init(lettersCount: Int = 5, attemptsNumber: Int = 5) {
        setLettersCount(lettersCount)
        setAttemptsNumber(attemptsNumber)
        
        gameLetters = Array(repeating: Array(repeating: nil, count: lettersCount), count: attemptsNumber)
        
        fillAllowedWords()
        
        generateRandomWord()
    }
    
    // MARK: - Game Settings
    
    mutating func setLettersCount(_ lettersCount: Int) {
        self.lettersCount = lettersCount
    }
    
    mutating func setAttemptsNumber(_ attemptsNumber: Int) {
        self.attemptsNumber = attemptsNumber
    }
    
    func getLettersCount() -> Int {
        lettersCount
    }
    
    func getAttemptsNumber()  -> Int {
        attemptsNumber
    }
    
    // MARK: - Randow Word
    
    private mutating func generateRandomWord() {
        guard let randomWord = allowedWords.randomElement() else {
            return
        }
        
        currentWord = randomWord.uppercased()
    }
    
    func getCurrentWord() -> String {
        currentWord
    }
    
    // MARK: - Allowed Words
    
    private mutating func fillAllowedWords() {
        let path = readFile()
        
        guard let allowedWordsArray = try? String(contentsOfFile: path, encoding: String.Encoding.utf8).split(separator: "\n") else {
            return }
        
        self.allowedWords = Set(allowedWordsArray)
    }
    
    func getAllowedWords() -> Set<Substring> {
        allowedWords
    }
    
    // MARK: - File Handing
    
    private func readFile() -> String {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return ""
        }
              
        return path
    }
}
