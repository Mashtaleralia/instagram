//
//  NotificationLikeEventTableViewCell.swift
//  instagram
//
//  Created by Admin on 05.05.2023.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: String)
}

class NotificationLikeEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationLikeEventTableViewCell"
      
      weak var delegate: NotificationFollowEventTableViewCellDelegate?
      
      private let profileImageView: UIImageView = {
          let imageView = UIImageView()
          imageView.layer.masksToBounds = true
          imageView.contentMode = .scaleAspectFit
          return imageView
      }()
      
      private let label: UILabel =  {
          let label = UILabel()
          label.textColor = .label
          label.numberOfLines = 0
          return label
      }()
      
      private let postButton: UIButton = {
          let button = UIButton()
          
          return button
      }()
      
      override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          contentView.clipsToBounds = true
          contentView.addSubview(postButton)
          contentView.addSubview(label)
          contentView.addSubview(profileImageView)
      }
      
      public func configure(with model: String) {
          
      }
      
      override func prepareForReuse() {
          super.prepareForReuse()
          postButton.setBackgroundImage(nil, for: .normal)
          label.text = nil
          profileImageView.image = nil
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
      
      override func layoutSubviews() {
          super.layoutSubviews()
      }

}
