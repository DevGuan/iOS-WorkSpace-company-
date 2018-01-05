//
//  Walk.swift
//  Dog Walk
//
//  Created by 刘松坡 on 14/11/8.
//  Copyright (c) 2014年 刘松坡. All rights reserved.
//

import Foundation
import CoreData

class Walk: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var dog: Dog

}
