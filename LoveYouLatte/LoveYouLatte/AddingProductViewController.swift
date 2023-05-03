//
//  AddingProductViewController.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import UIKit

class AddingProductViewController: UIViewController {

    let imageView: UIImageView = {
        let imgview = UIImageView()
        imgview.backgroundColor = .red
        imgview.translatesAutoresizingMaskIntoConstraints = false
        return imgview
    }()
    
    private let nameTextfield = TextField()
    
    private let priceTextfield = TextField()
    
    private let createProduct = UIButton(type: .system)
  

    
    // this is a horizontal stack view that is used to hold the donthaveAccLbl and createAccbtn
    private let hstackview: UIStackView = {
        // setting the properties of the horizontal stack view
        let stackview: UIStackView = UIStackView()
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 4
        return stackview
    }()
    
    /// vertical stack holds the hstackview and the forgotPass button
    private let vStackviw: UIStackView = {
        let stackview: UIStackView = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    
    private let selectLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Select Product Type"
        return lbl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUpTextfield(textfield: UITextField, defaultText: String) {
        textfield.backgroundColor = ColorConstants.gray
        textfield.placeholder = defaultText
        textfield.layer.cornerRadius = 8
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = ColorConstants.darkerGray.cgColor
        textfield.font = UIFont.systemFont(ofSize: 16)
    }
    
    
    
    func setUp() {
        imageView.backgroundColor = .yellow
        
        // setting the background color of the imagefield
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFill
        
        // looping to add them to a
        
        [imageView, nameTextfield, priceTextfield, createProduct].forEach { v in
            // enable programatic constraints
            v.translatesAutoresizingMaskIntoConstraints = false
            // add view to subview
            view.addSubview(v)
        }
        // making textifled be password
        priceTextfield.isSecureTextEntry = true
        
        // set up for textfield
        setUpTextfield(textfield: nameTextfield, defaultText: "Enter Product Name")
        setUpTextfield(textfield: priceTextfield, defaultText: "Enter Price")
        
        // set up loginButton
        createProduct.backgroundColor = ColorConstants.green
        createProduct.setTitle("Create", for: .normal)
        createProduct.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        createProduct.layer.cornerRadius = 25
        createProduct.tintColor = .white
        
        
        // adding stackview
        view.addSubview(hstackview)
        
        
        // adding vertical stackview
        view.addSubview(vStackviw)
        vStackviw.addArrangedSubview(hstackview)
    
        
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        let padding: CGFloat = 32
        // adding constraints for the email textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            nameTextfield.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            nameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            nameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            nameTextfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        // adding constraints for the password textfield
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            priceTextfield.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: padding-15),
            priceTextfield.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
            priceTextfield.trailingAnchor.constraint(equalTo: nameTextfield.trailingAnchor),
            priceTextfield.heightAnchor.constraint(equalToConstant: 41)
        ])
        
        
        
        // adding log in button
        NSLayoutConstraint.activate([
            // constraints top anchor of email to the bottom anchor of the image field with padding of 32
            createProduct.topAnchor.constraint(equalTo: priceTextfield.bottomAnchor, constant: padding),
            createProduct.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
            createProduct.trailingAnchor.constraint(equalTo: nameTextfield.trailingAnchor),
            createProduct.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // adding the dont have account info
        NSLayoutConstraint.activate([
            vStackviw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            vStackviw.topAnchor.constraint(equalTo: createProduct.bottomAnchor, constant: 23)
        ])
        
    }
    

}



// this is default textfield with left padding that I stole from stackoverflow
// https://stackoverflow.com/questions/25367502/create-space-at-the-beginning-of-a-uitextfield
class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
