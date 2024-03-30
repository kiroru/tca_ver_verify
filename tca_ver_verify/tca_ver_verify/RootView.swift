//
//  RootView.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import SwiftUI
import ComposableArchitecture

enum RootTab: Int, Hashable, CaseIterable {
    case home = 0
    case settings = 1
}

struct RootView: View {
    @State var store = Store(initialState: RootStore.State()) {
        RootStore()
    }
    @State var selection = RootTab.home
    
    var body: some View {
        WithPerceptionTracking {
            TabView(selection: $selection) {
                VStack {
                    Text("Home")
                    Button("push nav") {
                        store.send(.pushNav)
                    }
                }
                    .tabItem { Text("home") }
                    .tag(RootTab.home)

                Text("Settings")
                    .tabItem { Text("settings") }
                    .tag(RootTab.settings)
            }
            .onChange(of: selection) { newValue in
                store.send(.selectTab(newValue))
                selection = newValue
            }
            .fullScreenCover(
                isPresented: $store.presenting.sending(\.onPresent)
            ) {
                NavigationStack(path: $store.scope(state: \.path, action: \.path)
                ) {
                    EmptyView()
                } destination: { destination in
                    WithPerceptionTracking {
                        let scope = destination.case
                        switch scope {
                        case let .demo(store):
                            DemoView(store: store)
                        }
                    }
                }
            }
        }
        .alert(store: self.store.scope(state: \.$alert, action: \.alert))
    }
}
