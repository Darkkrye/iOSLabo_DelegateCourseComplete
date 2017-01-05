//
//  User.swift
//  iOSLabo_DelegateCourse
//
//  Created by Pierre on 03/12/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: Int
    var login: String
    var name: String
    var image: UIImage
    
    var url: String
    var reposCount: Int
    var gistsCount: Int
    var followersCount: Int
    var followingCount: Int
    
    var repos: [Repo]
    
    init(id: Int, login: String, name: String, image: String, url: String, reposCount: Int, gistsCount: Int, followersCount: Int, followingCount: Int, repos: [Repo]) {
        self.id = id
        self.login = login
        
        if name == "" {
            self.name = "Aucun nom définit"
        } else {
            self.name = name
        }
        
        if let url = URL(string: image) {
            do {
                let d = try Data(contentsOf: url)
                self.image = UIImage(data: d)!
            } catch {
                self.image = UIImage()
            }
            
        } else {
            self.image = UIImage()
        }
        
        self.url = url
        self.reposCount = reposCount
        self.gistsCount = gistsCount
        self.followersCount = followersCount
        self.followingCount = followingCount
        
        self.repos = repos
    }
}
