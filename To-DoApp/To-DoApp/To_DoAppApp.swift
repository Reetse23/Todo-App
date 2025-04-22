//
//  To_DoAppApp.swift
//  To-DoApp
//
//  Created by Thabiso Gaereetse on 2023/02/27.
//

import SwiftUI

@main
struct To_DoAppApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
            .environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
