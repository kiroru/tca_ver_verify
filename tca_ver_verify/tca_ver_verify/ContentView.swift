//
//  ContentView.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import SwiftUI
import CoreData
import ComposableArchitecture

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        RootView()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
