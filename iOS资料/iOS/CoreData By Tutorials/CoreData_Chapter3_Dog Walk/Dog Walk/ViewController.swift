//
//  ViewController.swift
//  Dog Walk
//
//  Created by 刘松坡 on 14/11/8.
//  Copyright (c) 2014年 刘松坡. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var managedContext: NSManagedObjectContext!
    var currentDog: Dog!
    
    @IBAction func add(sender: AnyObject) {
        
        let entity = NSEntityDescription.entityForName("Walk", inManagedObjectContext: managedContext)
        
        let walk = Walk(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        walk.date = NSDate()
        
        var walks = currentDog.walks.mutableCopy() as NSMutableOrderedSet
        
        walks.addObject(walk)
        
        currentDog.walks = walks.copy() as NSOrderedSet
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let entity = NSEntityDescription.entityForName("Dog", inManagedObjectContext: managedContext)
        
       // let dog = Dog(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        let dogName = "Fido"
        let dogFetch = NSFetchRequest(entityName: "Dog")
        dogFetch.predicate = NSPredicate(format: "name == %@", dogName)
        
        var error: NSError?
        let result = managedContext.executeFetchRequest(dogFetch, error: &error) as [Dog]?
        
        if let dogs = result {
            
            if dogs.count == 0 {
                currentDog = Dog(entity: entity!, insertIntoManagedObjectContext: managedContext)
                currentDog.name = dogName
                
                if !managedContext.save(&error) {
                    println("Could not save \(error), \(error?.userInfo)")
                }
            } else {
                currentDog = dogs[0]
            }
        } else {
            println("Could not fetch: \(error), \(error?.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0
        
        if let dog = currentDog? {
            numRows = dog.walks.count
        }
        
        return numRows
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.MediumStyle
        
        let walk = currentDog.walks[indexPath.row] as Walk
        
        cell.textLabel?.text = dateFormatter.stringFromDate(walk.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "List of Walks"
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            //1
            let walkToRemove = currentDog.walks[indexPath.row] as Walk
            
            //2
            let walks = currentDog.walks.mutableCopy() as NSMutableOrderedSet
            walks.removeObjectAtIndex(indexPath.row)
            currentDog.walks = walks.mutableCopy() as NSOrderedSet
            
            //3
            managedContext.deleteObject(walkToRemove)
            
            //4
            var error: NSError?
            if !managedContext.save(&error) {
                println("Could not delete \(error), \(error?.userInfo)")
            }
            
            //5
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
}

