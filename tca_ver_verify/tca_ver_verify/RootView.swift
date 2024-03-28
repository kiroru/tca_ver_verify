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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
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
                isPresented: viewStore.binding(get: \.presenting, send: { .onPresent($0) } )
            ) {
                NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
                    EmptyView()
                } destination: { store in
                    SwitchStore(store) {
                        switch $0 {
                        case .demo:
                            CaseLet(/RootStore.Path.State.demo,
                                     action: RootStore.Path.Action.demo) { _store in
                                DemoView(store: _store)
                            }
                        }
                    }
                }
            }
        }
        .alert(store: self.store.scope(state: \.$alert, action: { .alert($0) }))
    }
}
