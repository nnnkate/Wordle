//
//  GameManager.swift
//  Wordle
//
//  Created by Екатерина Неделько on 23.04.22.
//
import Foundation

struct GameManager {
    
    let lettersCount: Int
    let attemptsNumber: Int
    
    private var currentWord = ""
    private var allowedWords = Set<String>()
    
    private var gameLetters = [[LetterBox?]]()
    
    private let fileName = "AllowedWords"
    
    init(lettersCount: Int = 5, attemptsNumber: Int = 5) {
        self.lettersCount = lettersCount
        self.attemptsNumber = attemptsNumber
        
        gameLetters = Array(repeating: Array(repeating: nil, count: lettersCount), count: attemptsNumber)
        
        generateRandomWord()
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
        
        guard let allowedWords = try? String(contentsOfFile: path, encoding: String.Encoding.utf8).split(separator: "\n") as? [String] else {
            return }
        
        self.allowedWords = Set(allowedWords)
    }
    
    func getAllowedWords() -> Set<String> {
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
