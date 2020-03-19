//
//  TableViewHandler.swift
//  To-Do List
//
//  Created by Nigell Dennis on 3/18/20.
//  Copyright © 2020 Nigell Dennis. All rights reserved.
//

import RealmSwift
import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource, ItemCellDelegate {
    
    func deleteItem(cell: ItemCellView) {
        guard let indexPath = self.tableView.indexPath(for: cell) else {return}
        try! realm.write {
            realm.delete(todoList[indexPath.row])
        }
        tableView.reloadData()
    }
    
    func doneEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            try! realm.write {
                realm.delete(todoList[0])
            }
        }else{
            try! realm.write {
                todoList[0].note = textField.text!
            }
            textField.text = ""
            textField.isUserInteractionEnabled = false
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if todoList.isEmpty {
            tableView.setEmptyView(title: "Nothing?", message: "Great!")
        }else{
            tableView.restore()
        }
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCellView
        cell.delegate = self
        
        cell.label.text = todoList[indexPath.row].note
        
        if cell.label.text!.isEmpty {
            cell.label.isHidden = true
            cell.textField.isUserInteractionEnabled = true
            cell.textField.becomeFirstResponder()
        }else{
            cell.label.isHidden = false
            cell.textField.isUserInteractionEnabled = false
        }
        
        if todoList[indexPath.row].checked {
            UIView.animate(withDuration: 0.2) {
                cell.checkedUIView.alpha = 1.0
            }
            
        }else{
            UIView.animate(withDuration: 0.2) {
                cell.checkedUIView.alpha = 0.0
            }
        }
        
        if todoList[indexPath.row].checked {
            cell.contentDarkShadowLayer.shadowColor = UIColor(named: "LightShadow")?.cgColor
            cell.contentLightShadowLayer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
        }else{
            cell.contentLightShadowLayer.shadowColor = UIColor(named: "LightShadow")?.cgColor
            cell.contentDarkShadowLayer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        try! realm.write {
            todoList[indexPath.row].checked = !todoList[indexPath.row].checked
        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        emptyView.backgroundColor = UIColor(named: "Background")
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor(named: "Accent")
        titleLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 32)
        titleLabel.alpha = 0.7
        messageLabel.textColor = UIColor(named: "Accent")
        messageLabel.alpha = 0.5
        messageLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        let view = UIView()
        view.backgroundColor = UIColor(named: "Background")
        self.backgroundView = view
        self.separatorStyle = .none
    }
}
