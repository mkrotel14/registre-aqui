//
//  UIViewController+Context.swift
//  RegistreAqui
//
//  Created by Gian Carlo Mantuan on 03/01/22.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
