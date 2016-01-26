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
    
    var book: [String: String]!
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var bookCoverImageView: UIImageView!
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let validBookCover = self.book["Cover"] else { return }
        self.bookCoverImageView.image = UIImage(named: validBookCover)
        self.bookCoverImageView.contentMode = UIViewContentMode.ScaleAspectFit

        self.title = self.book["Title"] ?? nil
    }

}
