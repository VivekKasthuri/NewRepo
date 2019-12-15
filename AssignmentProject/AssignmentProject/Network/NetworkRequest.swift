//
//  NetworkRequest.swift
//  AssignmentProject
//
//  Created by Vivekvardhan Kasthuri on 27/11/19.
//  Copyright © 2019 Vivekvardhan Kasthuri. All rights reserved.
//

import Foundation
import UIKit

enum ErrorHandling: Error {
    
    case error
    case success
}

open class NetworkRequest {
    
    var complitionHandler: ((Welcome)->Void)?

     class func getList(success: @escaping ((Welcome)->Void), failure: @escaping ((ErrorHandling)->Void)) {

        let headers = [
          "User-Agent": "PostmanRuntime/7.15.2",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "Postman-Token": "ae5074b1-9868-41b8-994d-deacbdaea217,c9cecb5c-541d-45de-ad3d-acec25f9b8bb",
          "Host": "api.nytimes.com",
          "Accept-Encoding": "gzip, deflate",
          "Connection": "keep-alive",
          "cache-control": "no-cache"
        ]
        let request = NSMutableURLRequest(url: NSURL(string: "http://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=UEib6wnW64bQElRvqsTnJKTVkG1GRweR")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            failure(ErrorHandling.error)
          } else {
            let httpResponse = response as! HTTPURLResponse
            print(httpResponse)
            let utf8Data = String(decoding: data!, as: UTF8.self)
            let oridata = Data(utf8Data.utf8)
            let welcome = try? JSONDecoder().decode(Welcome.self, from: oridata)
            success(welcome!)
          }
        })

        dataTask.resume()
    }
    
    
    class func getTestList(url: String,completionHandler: @escaping ((Welcome)->Void)) {
       
        let headers = [
          "User-Agent": "PostmanRuntime/7.15.2",
          "Accept": "*/*",
          "Cache-Control": "no-cache",
          "Postman-Token": "ae5074b1-9868-41b8-994d-deacbdaea217,c9cecb5c-541d-45de-ad3d-acec25f9b8bb",
          "Host": "api.nytimes.com",
          "Accept-Encoding": "gzip, deflate",
          "Connection": "keep-alive",
          "cache-control": "no-cache"
        ]
           let request = NSMutableURLRequest(url: NSURL(string: url )! as URL,
                                                   cachePolicy: .useProtocolCachePolicy,
                                               timeoutInterval: 10.0)
           request.httpMethod = "GET"
           request.allHTTPHeaderFields = headers
           let session = URLSession.shared
           let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
             if (error != nil) {
                print(error!)
             } else {
               let httpResponse = response as? HTTPURLResponse
               print(httpResponse!)
                let utf8Data = String(decoding: data!, as: UTF8.self)
                let oridata = Data(utf8Data.utf8)
                let welcome = try? JSONDecoder().decode(Welcome.self, from: oridata)
             completionHandler(welcome!)
             }
           })

           dataTask.resume()
       }
}
