//
//  DetailViewController.swift
//  AssignmentProject
//
//  Created by Vivekvardhan Kasthuri on 27/11/19.
//  Copyright © 2019 Vivekvardhan Kasthuri. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var profilePic: AsyncImageView!
    @IBOutlet var titleLable: UILabel!
    @IBOutlet var authorLable: UILabel!
    @IBOutlet var dateLable: UILabel!
    var details: Result?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        titleLable.text = details?.title
        authorLable.text = details?.byline
        dateLable.text = details?.publishedDate
        profilePic.imageFromServerURL(url: (details?.media[0].mediaMetadata[0].url)!)
        
    }
}
