//
//  AppDelegate.swift
//  Todoey
//
//  Created by Mac on 07/08/18.
//  Copyright © 2018 ArnAmy. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //print(Realm.Configuration.defaultConfiguration.fileURL)

        do {
            let realm = try Realm()

        }catch{
            print("Error initialising new realm \(error)")
        }
        return true
    }


  
   
    // MARK: - Core Data stack
    
   
    
    // MARK: - Core Data Saving support
    
   

}

