//
//  IGPostActionsTableViewCell.swift
//  instagram
//
//  Created by Admin on 10.04.2023.
//

import UIKit

class IGPostActionsTableViewCell: UITableViewCell {
    
    
    static let identifier = "IGPostActionsTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
  

}
