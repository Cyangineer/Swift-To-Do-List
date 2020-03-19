//
//  ViewController.swift
//  To-Do List
//
//  Created by Nigell Dennis on 3/16/20.
//  Copyright © 2020 Nigell Dennis. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addItemButton: UIButton!
    
    
    let realm = try! Realm()
    
    lazy var todoList = {
        return realm.objects(Item.self).sorted(byKeyPath: "createdAt", ascending: false)
    }()
    
    let buttonLightShadowLayer = CAShapeLayer()
    let buttonDarkShadowLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ItemCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        setupAddButton()
    }
    
    func setupAddButton(){
        addItemButton.layer.cornerRadius = 11
        addItemButton.layer.masksToBounds = false
        
        buttonDarkShadowLayer.frame = addItemButton.bounds
        buttonDarkShadowLayer.backgroundColor = view.backgroundColor?.cgColor
        buttonDarkShadowLayer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
        buttonDarkShadowLayer.cornerRadius = 11
        buttonDarkShadowLayer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        buttonDarkShadowLayer.shadowOpacity = 1
        buttonDarkShadowLayer.shadowRadius = 2
        addItemButton.layer.insertSublayer(buttonDarkShadowLayer, below: addItemButton.imageView?.layer)
        
        buttonLightShadowLayer.frame = addItemButton.bounds
        buttonLightShadowLayer.backgroundColor = view.backgroundColor?.cgColor
        buttonLightShadowLayer.shadowColor = UIColor(named: "LightShadow")?.cgColor
        buttonLightShadowLayer.cornerRadius = 11
        buttonLightShadowLayer.shadowOffset = CGSize(width: -3.0, height: -3.0)
        buttonLightShadowLayer.shadowOpacity = 1
        buttonLightShadowLayer.shadowRadius = 2
        addItemButton.layer.insertSublayer(buttonLightShadowLayer, below: addItemButton.imageView?.layer)
    }
    
    @IBAction func buttonPressedDown(_ sender: UIButton) {
        buttonDarkShadowLayer.shadowColor = UIColor(named: "LightShadow")?.cgColor
        buttonLightShadowLayer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
    }
    @IBAction func buttonCancelled(_ sender: UIButton) {
        buttonLightShadowLayer.shadowColor = UIColor(named: "LightShadow")?.cgColor
        buttonDarkShadowLayer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        buttonLightShadowLayer.shadowColor = UIColor(named: "LightShadow")?.cgColor
        buttonDarkShadowLayer.shadowColor = UIColor(named: "DarkShadow")?.cgColor
        
        let newItem = Item()
        try! realm.write {
            realm.add(newItem)
        }
        tableView.reloadData()
    }
}
