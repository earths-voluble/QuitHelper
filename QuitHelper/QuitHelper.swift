//
//  QuitHelperApp.swift
//  QuitHelper
//
//  Created by 이보한 on 2023/03/28.
//

import SwiftUI

@main
struct QuitHelper: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environment(\.managedObjectContext,
                              persistenceController.container.viewContext)
        }
    }
}
