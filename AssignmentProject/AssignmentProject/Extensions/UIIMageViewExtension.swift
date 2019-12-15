//
//  UIIMageViewExtension.swift
//  AssignmentProject
//
//  Created by Vivekvardhan Kasthuri on 27/11/19.
//  Copyright © 2019 Vivekvardhan Kasthuri. All rights reserved.
//

import Foundation
import UIKit

class AsyncImageView: UIImageView {
    
    private var currentUrl: String? //Get a hold of the latest request url
    
    public func imageFromServerURL(url: String){
        currentUrl = url
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        let task = session.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in
            if error == nil {
                DispatchQueue.main.async {
                    if let downloadedImage = UIImage(data: data!) {
                        if (url == self.currentUrl) {
                            self.image = downloadedImage
                        }
                    }
                }
            } else {
                print(error as Any)
            }
        })
        task.resume()
    }
}
