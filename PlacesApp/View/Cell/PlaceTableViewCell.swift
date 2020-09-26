//
//  PlaceTableViewCell.swift
//  PlacesApp
//
//  Created by Hariharan on 26/09/20.
//  Copyright © 2020 Hariharan. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
      titleImageView.image = nil
    }
    
    var placeInfo:PlaceInfo? {
        didSet {
            guard let placeItem = placeInfo else {return}
            if let title = placeItem.title {
                titleLabel.text = title
            }
            
            if let description = placeItem.description {
                descriptionLabel.text = " \(description) "
            }
            
            if let imageHref = placeItem.imageHref {
                titleImageView.image = UIImage(named: imageHref)

            }
        }
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let titleImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        //img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .red
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(titleImageView)
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        self.contentView.addSubview(containerView)
        
        addconstratintForTitleImageView()
        addconstratintForContainerView()
        addconstratintForTitleLabel()
        addconstratintForDescriptionLabel()
    }
    
    func addconstratintForContainerView()
    {
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.titleImageView.trailingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true
    }
    
    func addconstratintForTitleImageView(){
        titleImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        titleImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        titleImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        titleImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
    }
    
    func addconstratintForTitleLabel(){
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    }
    
    func addconstratintForDescriptionLabel(){
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

