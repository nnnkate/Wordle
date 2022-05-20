//
//  LeadersBoardViewController.swift
//  Wordle
//
//  Created by Екатерина Неделько on 20.05.22.
//

import UIKit

class LeadersBoardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // temporary (for test)
        print(UserDefaultsService.shared.decodeObject(type: [[String: Int]].self, for: .leadersBoard) ?? [])
    }
}
