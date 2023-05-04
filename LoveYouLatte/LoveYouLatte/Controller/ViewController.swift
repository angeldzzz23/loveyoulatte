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
        title = "Products"
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
    
    view
    
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
    
        
        let rbutton = UIBarButtonItem(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.blue), landscapeImagePhone: nil, style: .done, target: self, action: #selector(rightBarButtonWasPressed))
        
        let rightButton: UIBarButtonItem = rbutton
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @objc func rightBarButtonWasPressed() {
        
        let vc = AddingProductViewController()
        self.navigationController?.pushViewController(AddingProductViewController(), animated: true)
        
        
    }


}




extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  products.count
    }
    

    
    func update(cell: ProductTableViewCell, at indexpath: IndexPath) {
      
        
        
        let api  = API()
        Task {
            do {
                
                
                guard let url = URL(string:"http://loveyoulatte.duckdns.org:5000/static/uploads/72babf3e-1484-4f4a-b715-258365e675aa.jpg") else {return}
                // products[indexpath.row].imageURL
               
                // TODO:
                let image = try await api.fetchImage(from: url)
               
                
                
                DispatchQueue.main.async {
                    cell.songCover.image = image
                    cell.productNameLbl.text = self.products[indexpath.row].name
                    cell.priceLbl.text = self.products[indexpath.row].price
                    
                }
                
                
                
            } catch { // prints an error
                print("error: ", error)

            }
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
            update(cell: cell, at: indexPath)
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
}
