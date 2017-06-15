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
            
            print("begine")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+4, execute: {
                
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
        cell?.backgroundColor = UIColor.init(white: 0.5, alpha: 0.6)
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

