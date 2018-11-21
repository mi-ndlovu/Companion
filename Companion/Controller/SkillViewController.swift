//
//  SkillViewController.swift
//  Companion
//
//  Created by Mbongeni NDLOVU on 2018/10/16.
//  Copyright © 2018 mndlovu. All rights reserved.
//

import UIKit

class SkillViewController: UIViewController {
    
    fileprivate var user : UserInfo = APIController.api42.loggedInUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SkillViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.skills.skills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "skillsCell", for: indexPath) as! SkillTableViewCell
        cell.skill.text = user.skills.skills[indexPath.row].name
        cell.level.text = String(format: "%.2f", user.skills.skills[indexPath.row].level)
        return cell
    }
}
