//
//  ProjectViewController.swift
//  Companion
//
//  Created by Mbongeni NDLOVU on 2018/10/16.
//  Copyright © 2018 mndlovu. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {
    
    fileprivate var user : UserInfo = APIController.api42.loggedInUser!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ProjectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.projects.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectTableViewCell
        cell.projectName.text = user.projects.projects[indexPath.row].slug
        let str = String(user.projects.projects[indexPath.row].grade)
        if user.projects.projects[indexPath.row].validated {
            cell.percentage.textColor = UIColor(red:0.04, green:0.67, blue:0.09, alpha:1.0)
        } else {
            cell.percentage.textColor = UIColor(red:0.92, green:0.08, blue:0.08, alpha:1.0)
        }
        cell.percentage.text = "\(str)%"
        return cell
    }
    
    
}
