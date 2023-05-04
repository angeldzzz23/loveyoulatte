//
//  ViewController.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import UIKit



class ViewController: UIViewController, AddingProductsDelegate {

    func productWasAdded() {
        products.removeAll()
        
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
                        self.productWithCategories = search
                        self.tableview.reloadData()
                    }
                }
            }
        }
    }
    
    let tableview: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        tb.backgroundColor = .systemGray6
        tb.translatesAutoresizingMaskIntoConstraints = false // enabling programic autolayout
        tb.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.identifier)
        
        return tb
        
    }()
    
    var products = [Product]()
    var productWithCategories: Products?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        title = "Products"
        setUpLayout()
        self.products.removeAll()
   
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let api = API()
        api.gettingProducts { res in
            switch res {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let search):
                DispatchQueue.main.async {
                    if let search = search {
                        self.products.removeAll()
                        self.products.append(contentsOf: search.coffee ?? [])
                        self.products.append(contentsOf: search.matcha ?? [])
                        self.products.append(contentsOf: search.signature ?? [])
                        self.products.append(contentsOf: search.tea ?? [])
                        self.productWithCategories = search
                        self.tableview.reloadData()

                    }
                }
            }
        }


    }
    
    func updateTheData() {
        let api = API()
        api.gettingProducts { res in
            switch res {
            case .failure(let err):
                print(err.localizedDescription)
            case .success(let search):
                DispatchQueue.main.async {
                    if let search = search {
                        self.products.removeAll()
                        self.products.append(contentsOf: search.coffee ?? [])
                        self.products.append(contentsOf: search.matcha ?? [])
                        self.products.append(contentsOf: search.signature ?? [])
                        self.products.append(contentsOf: search.tea ?? [])
                        self.productWithCategories = search
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
    
        
        let rbutton = UIBarButtonItem(image: UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.blue), landscapeImagePhone: nil, style: .done, target: self, action: #selector(rightBarButtonWasPressed))
        
        let rightButton: UIBarButtonItem = rbutton
        self.navigationItem.rightBarButtonItem = rightButton
        
    }
    
    @objc func rightBarButtonWasPressed() {
        
        let vc = AddingProductViewController()
        vc.delegate = self
        
        self.navigationController?.pushViewController(AddingProductViewController(), animated: true)
        
        
    }

    
    

}




extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let productWithCategories = productWithCategories {
            if section == 0 {
                let c = productWithCategories.coffee ?? []
                
                return c.count
                
            } else if section == 1 {
                let c = productWithCategories.matcha ?? []
                
                return c.count
                
            } else if section == 2 {
                let c = productWithCategories.signature ?? []
                
                return c.count
                
            } else if section == 3 {
                let c = productWithCategories.tea ?? []
                
                return c.count
                
            }
        }
        
        return  0
    }
    
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Coffee"
            
        } else if section == 1 {
            return "Match"
            
        } else if section == 2 {
            
            return "Signature"
            
        } else if section == 3 {
            
            return "Tea"
            
        }
        return "error"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    
    func helperToUpdate(indexpath: IndexPath ) -> Product? {
        
        if indexpath.section == 0 {
            var coffeeProducts = productWithCategories?.coffee ?? []
            if coffeeProducts.isEmpty {
                return nil
            }
            return coffeeProducts[indexpath.row]
        } else if indexpath.section == 1 {
            
            var matchaProducts = productWithCategories?.matcha ?? []
            if matchaProducts.isEmpty {
                return nil
            }
            return matchaProducts[indexpath.row]
            
        } else if indexpath.section == 2 {
            
            var signature = productWithCategories?.signature ?? []
            if signature.isEmpty {
                return nil
            }
            return signature[indexpath.row]
            
            
        } else if indexpath.section == 3 {
            var tea = productWithCategories?.tea ?? []
            if tea.isEmpty {
                return nil
            }
            return tea[indexpath.row]
        }
        
        
        
        return nil
    }

    
    func update(cell: ProductTableViewCell, at indexpath: IndexPath) {
      
        
        guard var product = helperToUpdate(indexpath: indexpath) else { return}
        
        let api  = API()
        
        Task {
            do {


                guard let url = URL(string:product.imageURL) else {return}
                // products[indexpath.row].imageURL

                // TODO:
                let image = try await api.fetchImage(from: url)



                DispatchQueue.main.async {
                    cell.songCover.image = image
                    cell.productNameLbl.text = product.name
                    cell.priceLbl.text = product.price

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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [unowned self] action, view, completionHandler in
            
            guard var product = helperToUpdate(indexpath: indexPath) else {return}
            
            
            let api = API()
            api.deleteProductWithId(id: String(product.id)) { res in
                switch res {
                case .success(let sc):
                    DispatchQueue.main.async {
                        updateTheData()
                        completionHandler(true)
                    }
                   
                case .failure(let error):
                    DispatchQueue.main.async {
                        print("there was an error")
                        completionHandler(true)
                    }
              
                }
            }
                
            
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
