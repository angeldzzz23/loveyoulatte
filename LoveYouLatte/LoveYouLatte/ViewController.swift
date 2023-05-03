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
        tb.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        return tb
        
    }()
    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "edit"
        setUpLayout()
        
        let api = API()
        
        api.gettingProducts { res in
            switch res {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let search):
                DispatchQueue.main.async {
                    if let search = search {
                        self.products.append(contentsOf: search.coffee ?? [])
                        self.products.append(contentsOf: search.matcha ?? [])
                        self.products.append(contentsOf: search.signature ?? [])
                        self.products.append(contentsOf: search.tea ?? [])
                        
                        self.tableview.reloadData()
                        
                        
                        
                    }

                    
                }
            }
        }
        
        
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
        
        tableview.dataSource = self
        tableview.delegate = self
    
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.products.count
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        
        cell.productNameLbl.text = products[indexPath.row].name
        cell.priceLbl.text = products[indexPath.row].price
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
}
