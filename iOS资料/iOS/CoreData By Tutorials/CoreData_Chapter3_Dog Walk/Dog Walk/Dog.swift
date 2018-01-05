//
//  Dog.swift
//  Dog Walk
//
//  Created by 刘松坡 on 14/11/8.
//  Copyright (c) 2014年 刘松坡. All rights reserved.
//

import Foundation
import CoreData

class Dog: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var walks: NSOrderedSet

}
