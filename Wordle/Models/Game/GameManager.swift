//
//  GameManager.swift
//  Wordle
//
//  Created by Екатерина Неделько on 23.04.22.
//
import Foundation

class GameManager {
    private var currentLetterIndexInRow = 0
    private var currentAttemptIndex = 0
    
    private (set) var lettersCount = 5
    private (set) var attemptsCount = 5
    
    private (set) var currentWord = ""
    private (set) var allowedWords = Set<String>()
    
    private (set) var gameField = [[LetterBox?]]()
    
    private let fileName = "AllowedWords"
    
    var delegate: GameDelegate?
    
    private var timer = Timer()
    private var timerCounter = 0
    
    private (set) var gameStatus: GameStatus = .playing {
        didSet {
            checkGameStatus()
        }
    }
    
    private let userName = UserDefaultsService.shared.decodeObject(type: String.self, for: .userName) ?? "User"
    
    private var lastCheckedRow: Int?
    
    init() {
        if UserDefaultsService.shared.decodeObject(type: Bool.self, for: .hardMode) ?? false {
            self.attemptsCount += 1
        }
        
        self.gameField = Array(repeating: Array(repeating: nil, count: lettersCount), count: attemptsCount)
        
        self.fillAllowedWords()
        
        self.generateRandomWord()
        
        self.startTimer()
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
            return
        }
        
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
    
    // MARK: - Hahdle Button Tap
    
    func handleButtonTap(type keyboardButtonType: KeyboardButtonType) {
        switch keyboardButtonType {
        case .enter:
            handleCheckWordButtonTap()
        case .delete:
            handleDeleteButtonTap()
        case .character(let string):
            handleCharacterButtonTap(string)
        }
    }
    
    private func handleCharacterButtonTap(_ letter: String) {
        if currentLetterIndexInRow >= lettersCount {
            return
        }
        
        gameField[currentAttemptIndex][currentLetterIndexInRow] = LetterBox(letter: letter, status: nil)
        
        currentLetterIndexInRow += 1
    }
    
    private func handleDeleteButtonTap() {
        let previousLetterIndex = currentLetterIndexInRow - 1
        
        if previousLetterIndex < 0 {
            return
        }
        
        gameField[currentAttemptIndex][previousLetterIndex] = nil
        
        currentLetterIndexInRow = previousLetterIndex
    }
    
    private func handleCheckWordButtonTap() {
        if currentLetterIndexInRow < lettersCount ||
            currentAttemptIndex >= attemptsCount ||
            gameStatus != .playing {
            return
        }
        
        guard let enteredWord = getEnteredWord() else {
            return
        }
        
        let currentWordArray = Array(currentWord)
        
        // temporary (for test)
        print(currentWordArray)
        
        for (index, letter) in enteredWord.enumerated() {
            if letter == currentWordArray[index] {
                gameField[currentAttemptIndex][index]?.setStatus(.correct)
                
                continue
            }
            
            if currentWord.contains(letter) {
                gameField[currentAttemptIndex][index]?.setStatus(.wrongLocation)
                
                continue
            }
            
            gameField[currentAttemptIndex][index]?.setStatus(.wrong)
        }
        
        if enteredWord == currentWord {
            handleGameResult(.win)
            
            return
        }
        
        currentAttemptIndex += 1
        currentLetterIndexInRow = 0
        
        if currentAttemptIndex == attemptsCount {
            handleGameResult(.lost)
        }
    }
    
    private func handleGameResult(_ status: GameStatus) {
        gameStatus = status
    }
    
    private func getEnteredWord() -> String? {
        let wordRow = gameField[currentAttemptIndex]
        
        var word = ""
        
        for letterBox in wordRow {
            guard let letter = letterBox?.letter else {
                return nil
            }
            
            word += letter
        }
        
        return word
    }
    
    func getEnteredWord() -> Word {
       var enteredWord = Word()
       var rowChecked = false

       for row in gameField {
           for cell in row {
               if let cell = cell {
                   if cell.status == nil {
                       rowChecked = true

                       enteredWord.append(cell)
                   }
               }
           }
           if rowChecked {
               break
           }
       }

       return enteredWord
   }
    
    // MARK: - Game Result
    
    func checkGameStatus() {
        if gameStatus != .playing {
            cancelTimer()
            updateLeadersBoard()
            delegate?.handleGameEnd(gameStatus)
        }
    }
    
    private func updateLeadersBoard() {
        var leadersBoardArray = UserDefaultsService.shared.decodeObject(type: [[String: GameResult]].self, for: .leadersBoard) ?? [[String: GameResult]]()
        
        leadersBoardArray.append([userName: GameResult(timerCounter: timerCounter, attemptCount: attemptsCount)])
        UserDefaultsService.shared.encodeObject(leadersBoardArray.self, for: .leadersBoard)
    }
    
    // MARK: -Timer
    
    private func startTimer() {
        timerCounter = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    private func cancelTimer() {
            timer.invalidate()
        }
    
    @objc private func timerAction() {
        timerCounter += 1
        delegate?.updateTimer(timerCounter)
    }
    
    // MARK: - Restart Game
    
    func restartGame() {
        currentLetterIndexInRow = 0
        currentAttemptIndex = 0
        
        generateRandomWord()
        
        gameField = Array(repeating: Array(repeating: nil, count: lettersCount), count: attemptsCount)
        
        gameStatus = .playing
        
        lastCheckedRow = nil
        
        startTimer()
    }
}

