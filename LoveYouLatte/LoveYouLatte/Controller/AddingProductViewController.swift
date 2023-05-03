//
//  AddingProductViewController.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import UIKit


enum ProductTypes {
    case coffee
    case matcha
    case signature
    case tea
    
    // this returns the product
    func getStrRepresentation()->String {
        switch self{
        case .coffee:
            return "coffee"
        case .matcha:
            return "matcha"
        case .signature:
            return "signature"
        case .tea:
            return "tea"
        }
    }
}

enum Validation: Error {
    case invalidProductName
    case invalidPrice
    case invalidProductType // must check at least one product
    case invalidImage
}


class AddingProductViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let imageView: UIImageView = {
        let imgview = UIImageView()
        imgview.backgroundColor = .red
        imgview.translatesAutoresizingMaskIntoConstraints = false
        return imgview
    }()
    
    private let nameTextfield = TextField()
    
    private let priceTextfield = TextField()
    
    private let createProduct = UIButton(type: .system)
  
    var typesEn: [ProductTypes] = [.coffee, .matcha, .signature, .tea]
    
    
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
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    // this will contain all of the horizontal seelct
    private let verticalSelect: UIStackView = {
        let stackview: UIStackView = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        stackview.alignment = .leading
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    
    private var allButtons = [UIButton]()
    
    func createButton() -> UIButton {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "circle"), for: .normal)
        btn.addTarget(self, action: #selector(buttonWasPressed), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }
    
    func createLBL(with text: String)-> UILabel {
        let lbl = UILabel()
        lbl.text = text
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
       return lbl
        
    }
    
    var selectedType: ProductTypes? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        setUp()
        // Do any additional setup after loading the view.
    }
    
    // validation
    func validateFields() throws {
        

        // validation for name textfield
        if nameTextfield.text == nil {
            throw Validation.invalidProductName
        }
        
        if let productName = nameTextfield.text {
            if productName.trimmingCharacters(in: .whitespaces).isEmpty {
                throw Validation.invalidProductName
            }
        }
        
       
        // validation for product textield
        
        if priceTextfield.text == nil {
            throw Validation.invalidPrice
        }
        
        if let priceTextfield = priceTextfield.text {
            if priceTextfield.trimmingCharacters(in: .whitespaces).isEmpty {
                throw Validation.invalidPrice
            }
        }
        
        // check if price is a double or an integer
        if let price = priceTextfield.text {
            if (Int(price) == nil) && (Double(price) == nil) {
                throw Validation.invalidPrice
            }
        }
        
        if selectedType == nil {
            throw Validation.invalidProductType
        }
        
        
        if imageView.image == nil {
            throw Validation.invalidImage
        }

    }
    
    

    // MARK: Actions
    @objc func imageviewWasPressed(gesture: UIGestureRecognizer) {
        if let imageView = gesture.view as? UIImageView {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = true
            
            picker.sourceType = .photoLibrary
            
            present(picker, animated: true, completion: nil)
            
            
        }
        
    }
    
    @objc func buttonWasPressed(button: UIButton) {
        
        // deselect all of the buttons
        
        allButtons.forEach { v in
            v.setImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        
        let indexOfbutton = allButtons.firstIndex(of: button) // 0
        
        selectedType = typesEn[indexOfbutton!]
        
        print(selectedType?.getStrRepresentation())
        
    }
    
    
    @objc func createProductButtonWasPressed() {
        let image = imageView.image!
        
        do {
            try validateFields()
            
        } catch Validation.invalidProductName {
            self.showAlert(with: "Invalid Product Name")
            

        } catch Validation.invalidPrice {
            self.showAlert(with: "Invalid Price")
            
        } catch Validation.invalidProductType {
            self.showAlert(with: "Invalid Product Type")
            
            
        } catch Validation.invalidImage {
            self.showAlert(with: "Invalid Please add image")
        } catch {
            self.showAlert(with: "Some other Error. BRBRBRRBRBRBRBR")
        }
        
        // we can add the image
        
        
        var param: Parameters = ["name": nameTextfield.text!, "price": priceTextfield.text!, "type": selectedType!.getStrRepresentation()]

        API.uploadingImage(parameters: param, mediaImage: .init(withImage: image, forKey: "image")!)
        
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    // MARK: UI set Up
    
    func setUpTextfield(textfield: UITextField, defaultText: String) {
        textfield.backgroundColor = ColorConstants.gray
        textfield.placeholder = defaultText
        textfield.layer.cornerRadius = 8
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = ColorConstants.darkerGray.cgColor
        textfield.font = UIFont.systemFont(ofSize: 16)
    }
    
    func generateHorizontalSV() -> UIStackView {
        let stackview: UIStackView = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 5
        stackview.alignment = .leading
        
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }
    
    
    func setUp() {
        view.addSubview(verticalSelect)
        
        typesEn.forEach { type in
            let sv = generateHorizontalSV()
            let btn = createButton()
            allButtons.append(btn)
            sv.addArrangedSubview(btn)
            sv.addArrangedSubview(createLBL(with: type.getStrRepresentation()))
            verticalSelect.addArrangedSubview(sv)
            
        }


        
        imageView.backgroundColor = .yellow
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageviewWasPressed))
          
          // 2. add the gesture recognizer to a view
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        // setting the background color of the imagefield
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFill
        
        // looping to add them to a
        
        [imageView, nameTextfield, priceTextfield, selectLbl, createProduct].forEach { v in
            // enable programatic constraints
            v.translatesAutoresizingMaskIntoConstraints = false
            // add view to subview
            view.addSubview(v)
        }
        
        
        // set up for textfield
        setUpTextfield(textfield: nameTextfield, defaultText: "Enter Product Name")
        setUpTextfield(textfield: priceTextfield, defaultText: "Enter Price")
        
        // set up loginButton
        createProduct.backgroundColor = ColorConstants.green
        createProduct.setTitle("Create", for: .normal)
        createProduct.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        createProduct.layer.cornerRadius = 25
        createProduct.tintColor = .white
        createProduct.translatesAutoresizingMaskIntoConstraints = false
        createProduct.addTarget(self, action: #selector(createProductButtonWasPressed), for: .touchUpInside)
        
        
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
        
        NSLayoutConstraint.activate([
            selectLbl.leadingAnchor.constraint(equalTo: priceTextfield.leadingAnchor),
            selectLbl.topAnchor.constraint(equalTo: priceTextfield.bottomAnchor, constant: padding)
        ])
        
        NSLayoutConstraint.activate([
            verticalSelect.leadingAnchor.constraint(equalTo: selectLbl.leadingAnchor),
            verticalSelect.topAnchor.constraint(equalTo: selectLbl.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            createProduct.topAnchor.constraint(equalTo: verticalSelect.bottomAnchor, constant: padding),
            createProduct.leadingAnchor.constraint(equalTo: priceTextfield.leadingAnchor),
            createProduct.trailingAnchor.constraint(equalTo: priceTextfield.trailingAnchor),
            createProduct.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    // MARK: ImagePicker
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 250, height: 250)
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    

}



extension UIViewController {
     func showAlert(with test: String) {
        var dialogMessage = UIAlertController(title: "Confirm", message: test, preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            // We dont print anything
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
}


