//
//  SongFeedItemTableViewCell.swift
//  LoveYouLatte
//
//  Created by Angel Zambrano on 5/3/23.
//

import UIKit


class ProductTableViewCell: UITableViewCell {
    
    static let identifier = "ProductFeedItemTableViewCell"
    
    
    let sv: UIStackView = {
       let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.spacing = 8
        return sv
    }()
    
    let songCover: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.backgroundColor = .yellow
        return imageview
    }()
    
    
    // song information
    let productHStaview: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.alignment = .leading
        sv.distribution = .fillProportionally
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    
    // this is a vertical stack view
    let productInfoSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.alignment = .leading
        sv.spacing = 8
        sv.distribution = .fillProportionally
        return sv
    }()
    
    let productNameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Latte"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let priceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$6.00"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    // TODO:
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupviews()
 
        
    }
    
    // TODO: ADD
    func setupviews() {
        
        contentView.addSubview(sv)
        
        NSLayoutConstraint.activate([
            sv.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            sv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            sv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            sv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
        
        sv.addArrangedSubview(productHStaview)
        productHStaview.addArrangedSubview(songCover)
        productHStaview.addArrangedSubview(productInfoSV)
        productInfoSV.addArrangedSubview(productNameLbl)
        productInfoSV.addArrangedSubview(priceLbl)
        
    
        NSLayoutConstraint.activate([

            songCover.widthAnchor.constraint(equalToConstant: 100),
            songCover.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
