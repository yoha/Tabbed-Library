//
//  BookCoverViewController.swift
//  Books Library
//
//  Created by Yohannes Wijaya on 1/23/16.
//  Copyright © 2016 Yohannes Wijaya. All rights reserved.
//

import UIKit

class BookCoverViewController: UIViewController {
    
    // MARK: - Stored Properties
    
    var book: [String: String]?
    
    lazy var bookCoverImage: UIImage? = {
        var image: UIImage?
        
        if self.book == nil {
            var buffer = [AnyObject]()
            
            guard let validPathToResource = NSBundle.mainBundle().pathForResource("Books", ofType: "plist"),  let validAuthors = NSArray(contentsOfFile: validPathToResource) as? [AnyObject] else { return image }
            for author in validAuthors {
                guard let validBooks = author["Books"] as? [AnyObject] else { return image }
                buffer += validBooks
            }
            
            if buffer.count > 0 {
                let random = Int(arc4random()) % buffer.count
                
                if let book = buffer[random] as? [String: String] {
                    self.book = book
                }
            }
        }
        
        if let book = self.book, let fileName = book["Cover"] {
            image = UIImage(named: fileName)
        }
        
        return image
    }()
    
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validBookCoverImage = self.bookCoverImage else { return }
        self.bookCoverImageView.image = validBookCoverImage
        self.bookCoverImageView.contentMode = UIViewContentMode.ScaleAspectFit

        self.title = self.book?["Title"] ?? nil
    }

}
