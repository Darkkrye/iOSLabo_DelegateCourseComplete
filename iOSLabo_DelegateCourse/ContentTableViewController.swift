//
//  ContentTableViewController.swift
//  iOSLabo_DelegateCourse
//
//  Created by Pierre on 03/12/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import UIKit

class ContentTableViewController: UITableViewController {
    
    let blackImageView = UIView()
    var newImageView = UIImageView()
    
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set delegate for APIManager
        // Call APIManager getGithubUserInformation function
        APIManager.shared.delegate = self
        APIManager.shared.getGithubUserInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// Extension for TableView Delegate & Datasource
extension ContentTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let u = self.user {
            return u.repos.count
        }
        return 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        // Configure the cell...
        if let u = self.user {
            if indexPath.row == 0 {
                var profileCell: ProfileTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as? ProfileTableViewCell
                
                if profileCell == nil {
                    profileCell = ProfileTableViewCell.profileCell()
                }
                
                profileCell.userImageIV.image = u.image
                profileCell.userImageIV.layer.cornerRadius = 10
                
                profileCell.pseudoL.text = u.login
                profileCell.nameL.text = u.name
                
                profileCell.followersCountL.text = "\(u.followersCount)"
                profileCell.reposCountL.text = "\(u.reposCount)"
                profileCell.gistsCountL.text = "\(u.gistsCount)"
                profileCell.followingCountL.text = "\(u.followingCount)"
                
                // Set delegate for ProfileTableViewCell
                profileCell.delegate = self
                
                cell = profileCell
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
                
                let r = u.repos[indexPath.row - 1]
                
                cell.textLabel?.text = r.name
                cell.detailTextLabel?.text = "Langage: \(r.language)"
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        } else {
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

// Create extension for APIManagerDelegate
// Add getUserReposCallback function
// Add the following code inside the function :
extension ContentTableViewController: APIManagerDelegate {
    func getUserReposCallback(statusCode: Int, userData: Data, reposData: Data) {
        let userJson = JSON(data: userData)
        let reposJson = JSON(data: reposData)
        
        var repos = [Repo]()
        
        for repo in reposJson {
            let r = repo.1
            repos.append(Repo(id: r["id"].intValue, name: r["name"].stringValue, fullName: r["full_name"].stringValue, url: r["url"].stringValue, language: r["language"].stringValue, defaultBranch: r["default_branch"].stringValue))
        }
        
        self.user = User(id: userJson["id"].intValue, login: userJson["login"].stringValue, name: userJson["name"].stringValue, image: userJson["avatar_url"].stringValue, url: userJson["html_url"].stringValue, reposCount: userJson["public_repos"].intValue, gistsCount: userJson["public_gists"].intValue, followersCount: userJson["followers"].intValue, followingCount: userJson["following"].intValue, repos: repos)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension ContentTableViewController: ProfileTableViewCellDelegate {
    func onImageTapped(userImageView: UIImageView) {
        let alert = UIAlertController(title: "Tapped image", message: "Vous avez cliqué sur l'image", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


// ------------------------------------------------


// Create extension for ProfileTableViewCellDelegate
// Add onImageTapped function
// Add the following code inside the function :

/*

*/
