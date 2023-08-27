//
//  FormTableViewCell.swift
//  instagram
//
//  Created by Admin on 12.04.2023.
//

import UIKit

protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updatedModel: EditProfileFormModel )
    
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    static let identifier = "FormTableViewCellIdentifier"
    
    public weak var delegate: FormTableViewCellDelegate?
    
    private var model: EditProfileFormModel?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(label)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        label.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        field.placeholder = nil
        field.text = nil
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 5,
                             y: 0,
                             width: contentView.width/3,
                             height: contentView.height)
        field.frame = CGRect(x: label.right + 5,
                             y: 0,
                             width: contentView.width - 10 - label.width,
                             height: contentView.height)
    }
    //MARK: - Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        //delegate?.formTableViewCell(self, didUpdateField: textField.text)
        textField.resignFirstResponder()
        return true
    }
   
    
}
