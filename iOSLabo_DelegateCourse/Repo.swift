//
//  Repo.swift
//  iOSLabo_DelegateCourse
//
//  Created by Pierre on 03/12/2016.
//  Copyright © 2016 Pierre Boudon. All rights reserved.
//

import UIKit

class Repo: NSObject {
    var id: Int
    var name: String
    var fullName: String
    
    var url: String
    var language: String
    var defaultBranch: String
    
    init(id: Int, name: String, fullName: String, url: String, language: String, defaultBranch: String) {
        self.id = id
        self.name = name
        self.fullName = fullName
        
        self.url = url
        self.language = language
        self.defaultBranch = defaultBranch
    }
}
