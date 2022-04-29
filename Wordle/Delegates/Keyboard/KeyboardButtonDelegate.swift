//
//  KeyboardButtonDelegate.swift
//  Wordle
//
//  Created by Екатерина Неделько on 28.04.22.
//

protocol KeyboardButtonDelegate {
    func characterButtonTap(_ letterBox: LetterBox)
    func deleteButtonTap()
    func checkWordButtonTap()
}
