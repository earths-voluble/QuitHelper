//
//  Persistence.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/28.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "DailyData")
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Container load failed: \(error)")
            }
        }
    }
}
