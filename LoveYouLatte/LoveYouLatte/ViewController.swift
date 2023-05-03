//
//  ViewController.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import UIKit

class ViewController: UIViewController {

    let tableview: UITableView = {
       let tb = UITableView()
        tb.backgroundColor = .systemGray6
        tb.translatesAutoresizingMaskIntoConstraints = false // enabling programic autolayout
        return tb
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "edit"
        setUpLayout()
        
    }
    
    // MARK: setting up
    
    // setting up constraints and the views
    private func setUpLayout() {
        view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    
    }

}

