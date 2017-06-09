//
//  ViewController.swift
//  AnimateReferesh
//
//  Created by 迟钰林 on 2017/6/9.
//  Copyright © 2017年 迟钰林. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(NSClassFromString("UITableViewCell"), forCellReuseIdentifier: "cell")
        self.tableView.refereshHeader = CYLRefereshHeader.init(block: { 
            
            print("beginre")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: { 
                
                self.tableView.refereshHeader?.endRefereshing()
            })
            
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
         return 10
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.backgroundColor = UIColor.lightGray
        return cell!
    }
    
}

