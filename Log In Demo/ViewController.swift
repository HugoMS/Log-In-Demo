//
//  ViewController.swift
//  Log In Demo
//
//  Created by Hugo Morelli on 10/14/16.
//  Copyright © 2016 Hugo Morelli. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logOutButton: UIButton!
    var isloggedIn = false
    
    //MARK: Actions
    @IBAction func logOut(_ sender: AnyObject) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    
                    context.delete(result )
                    do{
                    
                        try context.save()
                        
                    } catch {
                        print("Individual Delete Failed")
                    }
            }
                
                
                
                logOutButton.alpha = 0
                
                name.text = ""
                
                logInButton.setTitle("Login", for: [])
                
                name.alpha = 1
                
                logInButton.alpha = 1
                
                label.alpha = 0 
                
                isloggedIn = false
                
               
        }
        
            
        } catch {
            print("Delete Failed")
        }
        
        
        
    }
     @IBAction func logIn(_ sender: AnyObject) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        if isloggedIn{
            
            let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")

            do {
                
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        result.setValue(name.text, forKey: "name")
                        
                        do {
                        
                            try context.save()
                            
                        } catch {
                        
                        }
                    }
                    
                    label.text = "Hi there " + name.text! + "!"
                }
                
            } catch {
                print("Update Username Failed")
            }
        
        }
        else {
            
            let newValue = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
            
            newValue.setValue(name.text, forKey: "name")
            
            do{
                
                try context.save()
                
                name.alpha = 0
                

                
                logInButton.setTitle("Update username", for: [])

                
                label.alpha = 1
                
                logOutButton.alpha = 1
                
                label.text = "Hi there " + name.text! + "!"
                
                isloggedIn = true
                
                name.alpha = 1
                
            }catch{
                print("Fail to saved")
            }
        }
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        request.returnsObjectsAsFaults = false
        do{
        
            let results = try context.fetch(request)
            
            for result in results as! [NSManagedObject]{
            
                if let usermane =  result.value(forKey: "name") as? String  {
                
                    name.alpha = 1
                    
                    logInButton.setTitle("Update username", for: [])
                    
                    label.alpha = 1
                    
                    logOutButton.alpha = 1
                    
                    label.text = "Hi there " + usermane + "!"
                }
                
                
                
            }
            
            
        }catch{
            print("Error")
        
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

