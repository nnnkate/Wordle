//
//  LeadersBoardTableViewCell.swift
//  Wordle
//
//  Created by Екатерина Неделько on 24.05.22.
//

import UIKit

class LeadersBoardTableViewCell: UITableViewCell {
    static let id = "LeadersBoardTableViewCell"
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var attemptsCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateData(userName: String, gameResult: GameResult) {
        userNameLabel.text = userName
        timeLabel.text = gameResult.timerCounter.getTimerString()
        attemptsCountLabel.text = String(gameResult.attemptCount)
    }
}
