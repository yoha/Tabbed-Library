//
//  BooksTableViewController.swift
//  Books Library
//
//  Created by Yohannes Wijaya on 1/23/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    // MARK: - Stored Properties
    
    var author: [String: AnyObject]?

    lazy var books: [AnyObject] = {
        var buffer = [AnyObject]()
        
        guard let validAuthor = self.author, let validBooks = validAuthor["Books"] as? [AnyObject] else {
            guard let validFilePathToResources = NSBundle.mainBundle().pathForResource("Books", ofType: "plist"), let authors = NSArray.init(contentsOfFile: validFilePathToResources) as? [AnyObject] else { return buffer }
            for author in authors {
                if let book = author["Books"] as? [AnyObject] {
                    buffer += book
                }
            }
            return buffer
        }
        buffer += validBooks
        return buffer
    }()

    let bookTableViewCellIdentifier = "BookTableViewCellIdentifier"
    let bookCoverViewControllerSegue = "BookCoverViewControllerSegue"
    
    // MARK: - NSCoding Protocol Initializer
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.tabBarItem = UITabBarItem(title: "Books", image: UIImage(named: "icon-books"), tag: 1)
        self.tabBarItem.badgeValue = "7"
    }
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: self.bookTableViewCellIdentifier)
        
        self.title = self.author?["Author"] as? String ?? "Books"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == self.bookCoverViewControllerSegue {
            if let validIndexPathForSelectedRow = self.tableView.indexPathForSelectedRow, let validBook = self.books[validIndexPathForSelectedRow.row] as? [String: String] {
                guard let validDestinationVieWController = segue.destinationViewController as? BookCoverViewController else { return }
                validDestinationVieWController.book = validBook
            }
        }
    }
    
    // MARK: - UITableViewDelegate Methods
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(self.bookCoverViewControllerSegue, sender: self)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UITableViewDataSource Methods

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.books.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.bookTableViewCellIdentifier, forIndexPath: indexPath)

        // Configure the cell...
        
        if let book = self.books[indexPath.row] as? [String: String], let bookTitle = book["Title"] {
            cell.textLabel?.text = bookTitle
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
