//
//  Evaluation.swift
//  Wordle
//
//  Created by Екатерина Неделько on 22.04.22.
//

typealias Word = [LetterBox]

enum Evaluation {
    case wrong
    case wrongLocation
    case correct
}
