//
//  tca_ver_verifyApp.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import SwiftUI

@main
struct tca_ver_verifyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
