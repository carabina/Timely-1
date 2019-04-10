//
//  BookmarksViewController.swift
//  Timely2
//
//  Created by Mihai Leonte on 3/29/19.
//  Copyright © 2019 Mihai Leonte. All rights reserved.
//

import UIKit
import os

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like viewDidLoad.
    static let viewCycle = OSLog(subsystem: subsystem, category: "viewcycle")
}

class BookmarksViewController: UIViewController {
    var childVC: StoriesChildViewController?
   

    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("BookmarksViewController did load.", log: OSLog.viewCycle, type: .debug)
        
        guard let childVC = childVC else { return }
        
        childVC.isStoriesChildView = false
        childVC.currentSelectedSourceAPI = .official
        childVC.state = .loading
        childVC.storiesOfficialAPI = Bookmarks.shared.stories
        childVC.state = .populated
        childVC.fetchOfficialApiStoryItems()
    }

    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedBookmarksChildVC" {
            if let childDestination = segue.destination as? StoriesChildViewController {
                childDestination.parentVC = self
                self.childVC = childDestination
            }
        }
    }
}
