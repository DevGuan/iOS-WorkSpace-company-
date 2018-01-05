//
//  Bowtie.swift
//  Bow Ties
//
//  Created by 刘松坡 on 14/11/7.
//  Copyright (c) 2014年 刘松坡. All rights reserved.
//

import Foundation
import CoreData

class Bowtie: NSManagedObject {

    @NSManaged var isFavorite: NSNumber
    @NSManaged var lastWorn: NSDate
    @NSManaged var name: String
    @NSManaged var photoData: NSData
    @NSManaged var rating: NSNumber
    @NSManaged var searchKey: String
    @NSManaged var timesWorn: NSNumber
    @NSManaged var tintColor: AnyObject

}
