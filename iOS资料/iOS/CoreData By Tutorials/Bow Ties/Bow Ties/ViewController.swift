//
//  ViewController.swift
//  Bow Ties
//
//  Created by 刘松坡 on 14/11/7.
//  Copyright (c) 2014年 刘松坡. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    var managedContext : NSManagedObjectContext!
    var currentBowtie: Bowtie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        insertSimpleData()
        
        //2
        
        let request = NSFetchRequest(entityName: "Bowtie")
        let firstTitle = self.segmentedControl.titleForSegmentAtIndex(0)!
        
        request.predicate = NSPredicate(format: "searchKey == %@", firstTitle)
        
        //3
        var error: NSError?
        var results = managedContext.executeFetchRequest(request, error: &error) as [Bowtie]?
        
        //4
        //作为可选类型的存在与否的判定
        if let bowties = results {
            currentBowtie = bowties[0]
            populate(currentBowtie)
        } else {
            println("Could not fetch \(error), \(error?.userInfo)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func segmentedControl(sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegmentAtIndex(sender.selectedSegmentIndex)
        
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        
        fetchRequest.predicate = NSPredicate(format: "searchKey == %@", selectedValue!)
        
        var error: NSError?
        let results = managedContext.executeFetchRequest(fetchRequest, error: &error) as [Bowtie]?
        
        if let bowties = results {
            currentBowtie = bowties.last
            populate(currentBowtie)
        } else {
            println("Could not fetch \(error), \(error?.userInfo)")
        }
    }

    @IBAction func wear(sender: UIButton) {
        let times = currentBowtie.timesWorn.integerValue
        currentBowtie.timesWorn = NSNumber(integer: (times + 1))
        
        currentBowtie.lastWorn = NSDate()
        
        var error: NSError?
        
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        self.populate(currentBowtie)
    }
    
    @IBAction func rate(sender: AnyObject) {
        let alert = UIAlertController(title: "New Rating", message: "Rate this bow tie", preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            
        }
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.updateRating(textField.text)
        }

        alert.addTextFieldWithConfigurationHandler { (textFiled: UITextField!) -> Void in
            
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func updateRating(numericString: String) {
        let rating = (numericString as NSString).doubleValue
        currentBowtie.rating = NSNumber(double: rating)
        var error: NSError?
        if !managedContext.save(&error) {
            //println("Could not save \(error), \(error?.userInfo)")
            if error!.code == NSValidationNumberTooSmallError || error!.code == NSValidationNumberTooLargeError {
                println(error!)
                rate(currentBowtie)
            }
        } else {
            populate(currentBowtie)
        }
    }
    
    func populate(bowtie: Bowtie) {
        self.imageView.image = UIImage(data: bowtie.photoData)
        self.nameLabel.text = bowtie.name
        self.ratingLabel.text = "Rating:\(bowtie.rating.doubleValue)/5"
        self.timesWornLabel.text = "# of times worn:\(bowtie.timesWorn.integerValue)"
        
        let df = NSDateFormatter()
        df.dateStyle = NSDateFormatterStyle.ShortStyle
        df.timeStyle = NSDateFormatterStyle.NoStyle
        
        self.lastWornLabel.text = "Last worn:\(df.stringFromDate(bowtie.lastWorn))"
        self.favoriteLabel.hidden = !bowtie.isFavorite.boolValue
        
        view.tintColor = bowtie.tintColor as UIColor
    }
    
    func insertSimpleData() {
        let fetchRequest = NSFetchRequest(entityName: "Bowtie")
        fetchRequest.predicate = NSPredicate(format: "searchKey != nil")
        
        
        let count = managedContext.countForFetchRequest(fetchRequest, error: nil)
        
        if count > 0 {
            return
        }
        
        let path = NSBundle.mainBundle().pathForResource("SampleData", ofType: "plist")!

        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            let dataArray = NSArray(contentsOfFile: path)
            
            for dict: AnyObject in dataArray! {
                let entity = NSEntityDescription.entityForName("Bowtie", inManagedObjectContext: managedContext)
                
                let bowtie = Bowtie(entity: entity!, insertIntoManagedObjectContext: managedContext)
                
                let btDict = dict as NSDictionary
                
                bowtie.name = btDict["name"] as String
                bowtie.searchKey = btDict["searchKey"] as String
                bowtie.rating = btDict["rating"] as NSNumber
                
                let tintColorDict = btDict["tintColor"] as NSDictionary
                bowtie.tintColor = colorFromDic(tintColorDict)
                
                let imageName = btDict["imageName"] as String
                let image = UIImage(named: imageName)
                bowtie.photoData = UIImagePNGRepresentation(image)
                
                bowtie.lastWorn = btDict["lastWorn"] as NSDate
                bowtie.timesWorn = btDict["timesWorn"] as NSNumber
                bowtie.isFavorite = btDict["isFavorite"] as NSNumber
                
                var error: NSError?
                if !managedContext.save(&error) {
                    println("Could not save \(error), \(error?.userInfo)")
                }
            }
        } else {
            NSLog("文件不存在")
        }
    }
    
    func colorFromDic(dic: NSDictionary) -> UIColor {
        var red = dic["red"] as NSNumber
        var green = dic["green"] as NSNumber
        var blue = dic["blue"] as NSNumber
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1)
    }
    
}

