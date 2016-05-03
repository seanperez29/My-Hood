//
//  ViewController.swift
//  My Hood
//
//  Created by Sean Perez on 4/26/16.
//  Copyright © 2016 Sean Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        DataService.instance.loadPosts()
        //Can set height of cell as indicated below if you want the cell to have the ability to grow. You do have to set up your constraints a certain way in order to allow that. But we are going to set a fixed height with a function below.
        //tableView.estimatedRowHeight = 87
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.onPostsLoaded(_:)), name: "postsLoaded", object: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.loadedPosts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let post = DataService.instance.loadedPosts[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as? PostCell {
            cell.configureCell(post)
            return cell
        } else {
            let cell = PostCell()
            cell.configureCell(post)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 87.0
    }
    
    //The function below is if you want the ability to select a row to load a new view or some new data or have it take you somewhere else. But we are just going to have the ability with this app to view things and not edit.
    //func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {}
    
    func onPostsLoaded(notif: AnyObject) {
        tableView.reloadData()
    }

}

