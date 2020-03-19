//
//  ItemCell.swift
//  To-Do List
//
//  Created by Nigell Dennis on 3/16/20.
//  Copyright © 2020 Nigell Dennis. All rights reserved.
//

import UIKit

protocol ItemCellDelegate {
    func doneEditing(_ textField: UITextField)
    func deleteItem(cell: ItemCellView)
}

class ItemCellView: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkedImageView: UIImageView!
    @IBOutlet weak var checkedUIView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var contentUIView: UIView!
    
    var delegate: ItemCellDelegate?
    let contentLightShadowLayer = CAShapeLayer()
    let contentDarkShadowLayer = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
        setupContentView()
        setupCheckView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 17.5, left: 28, bottom: 17.5, right: 28))
        contentDarkShadowLayer.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        contentLightShadowLayer.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.doneEditing(textField)
        return self.endEditing(true)
    }
    
    @IBAction func deleteItem(_ sender: UIButton) {
        delegate?.deleteItem(cell: self)
    }
    
    func setupContentView(){
        contentUIView.layer.cornerRadius = 11
        contentView.layer.masksToBounds = false
        
        contentDarkShadowLayer.frame = contentView.frame
        contentDarkShadowLayer.backgroundColor = contentUIView.backgroundColor?.cgColor
        contentDarkShadowLayer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
        contentDarkShadowLayer.cornerRadius = 11
        contentDarkShadowLayer.shadowOffset = CGSize(width: 3, height: 3)
        contentDarkShadowLayer.shadowOpacity = 1
        contentDarkShadowLayer.shadowRadius = 2
        contentView.layer.insertSublayer(contentDarkShadowLayer, at: 0)
        
        contentLightShadowLayer.frame = contentView.frame
        contentLightShadowLayer.backgroundColor = contentUIView.backgroundColor?.cgColor
        contentLightShadowLayer.shadowColor = UIColor.white.cgColor
        contentLightShadowLayer.cornerRadius = 11
        contentLightShadowLayer.shadowOffset = CGSize(width: -3, height: -3)
        contentLightShadowLayer.shadowOpacity = 1
        contentLightShadowLayer.shadowRadius = 2
        contentView.layer.insertSublayer(contentLightShadowLayer, at: 0)
    }
    
    func setupCheckView(){
        checkedUIView.layer.cornerRadius = 17.5
        checkedUIView.layer.masksToBounds = false
        checkedUIView.layer.shadowRadius = 2
        checkedUIView.layer.shadowOpacity = 1
        checkedUIView.layer.shadowOffset = CGSize( width: 3, height: 3)
        checkedUIView.layer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = checkedUIView.bounds
        shadowLayer.backgroundColor = checkedUIView.backgroundColor?.cgColor
        shadowLayer.shadowColor = UIColor(named: "LightShadow")?.cgColor
        shadowLayer.cornerRadius = 17.5
        shadowLayer.shadowOffset = CGSize(width: -2, height: -2)
        shadowLayer.shadowOpacity = 1
        shadowLayer.shadowRadius = 2
        checkedUIView.layer.insertSublayer(shadowLayer, at: 0)
    }
}
