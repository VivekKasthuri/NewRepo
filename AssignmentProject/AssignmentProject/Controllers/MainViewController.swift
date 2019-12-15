//
//  ViewController.swift
//  AssignmentProject
//
//  Created by Vivekvardhan Kasthuri on 27/11/19.
//  Copyright © 2019 Vivekvardhan Kasthuri. All rights reserved.
//

import UIKit
import Reachability

class MainViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var tableViewDatsource: MainTableVeiwDataSource?
    var list: Welcome?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CustomTableViewTableViewCell", bundle: nil), forCellReuseIdentifier: CustomTableViewTableViewCell.identifier)
        self.tableView.estimatedRowHeight = 45
        self.tableView.rowHeight = UITableView.automaticDimension
        self.checkForInternetConnection()
    }
    
    func checkForInternetConnection() {
        let reachability = try! Reachability()
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            getData()
        case .cellular:
            print("Reachable via Cellular")
            getData()
        case .unavailable:
            print("Network not reachable")
        case .none:
            print("Some issues")
        }
    }
    
    func getData() {
        NetworkRequest.getList(success: { (welcome) in
            self.list = welcome
            DispatchQueue.main.async {
                self.self.tableViewDatsource = MainTableVeiwDataSource(tableView: self.tableView, list: self.list!)
                self.tableView.reloadData()
            }
        }) { (error) in
            switch error {
            case .error:
                print("Error")
            case .success:
                print("Success")
            }
        }
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigateToNextView(item: (list?.results[indexPath.row])!)
    }
    
    func navigateToNextView(item: Result) {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let detailView = storyBoard.instantiateViewController(identifier: "detailView") as? DetailViewController
        detailView?.details = item
        self.navigationController?.pushViewController(detailView!, animated: true)
        self.navigationController?.topViewController?.navigationItem.title = "DetailsViewController"
    }
}




