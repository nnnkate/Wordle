//
//  LeadersBoardViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 20.05.22.
//

import UIKit

class LeadersBoardViewController: UIViewController {
    @IBOutlet weak var leadersBoardTable: UITableView!
    
    let leadersBoardData: [(String, GameResult)] =
    (UserDefaultsService.shared.decodeObject(type: [String: GameResult].self, for: .leadersBoard) ?? [String: GameResult]()).map{ ($0.key, $0.value) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leadersBoardTable.delegate = self
        leadersBoardTable.dataSource = self
        
        leadersBoardTable.reloadData()
        
        leadersBoardTable.register(UINib(nibName: "LeadersBoardTableViewCell", bundle: nil),
                           forCellReuseIdentifier: LeadersBoardTableViewCell.id)
    }
}

extension LeadersBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let row = sections[indexPath.section].rows[indexPath.row]
//
//        print(row)
    }
}

extension LeadersBoardViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leadersBoardData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let leadersBoardTableViewCell = leadersBoardTable.dequeueReusableCell(withIdentifier: LeadersBoardTableViewCell.id) as? LeadersBoardTableViewCell else {
            return UITableViewCell()
        }

//        let row = sections[indexPath.section].rows[indexPath.row]
//
//        tableViewCell.updateData(imageName: row.imageName,
//                                 text: row.title)

        leadersBoardTableViewCell.updateData(leadersBoardData[indexPath.row].0)
        
        return leadersBoardTableViewCell
    }
}
