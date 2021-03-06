//
//  AuthorsTableViewController.swift
//  Books Library
//
//  Created by Yohannes Wijaya on 1/21/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class AuthorsTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    
    var authors = [AnyObject]()
    
    let authorTableViewCellIdentifier = "AuthorTableViewCellIdentifier"
    let booksTableViewControllerSegue = "BooksTableViewControllerSegue"
    
    // MARK: - NSCoding Protocol Initializer
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tabBarItem = UITabBarItem(title: "Authors", image: UIImage(named: "icon-authors"), tag: 0)
    }
    
    // MARK: - UIViewController Methods
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.booksTableViewControllerSegue {
            if let validIndexPathForSelectedRow = self.tableView.indexPathForSelectedRow, let validAuthor = self.authors[validIndexPathForSelectedRow.row] as? [String: AnyObject] {
                guard let validDestinationViewController = segue.destinationViewController as? BooksTableViewController else { return }
                validDestinationViewController.author = validAuthor
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validFilePathToResources = NSBundle.mainBundle().pathForResource("Books", ofType: "plist") else { return }
        self.authors = NSArray(contentsOfFile: validFilePathToResources) as! [AnyObject]
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.authorTableViewCellIdentifier)
        
        self.title = "Authors"
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(self.booksTableViewControllerSegue, sender: self)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - UITableViewDataSource Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authors.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.authorTableViewCellIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        
        if let author = self.authors[indexPath.row] as? [String: AnyObject], let authorName = author["Author"] as? String {
            cell.textLabel?.text = authorName
        }
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
