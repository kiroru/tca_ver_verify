//
//  DemoView.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import SwiftUI
import ComposableArchitecture

struct DemoView: View {
    let store: StoreOf<DemoStore>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    Text("\(viewStore.count)")
                }
                Section {
                    Button("Push") {
                        viewStore.send(.increment)
                    }
                    Button("Dismiss") {
                        viewStore.send(.dismissButtonTapped)
                    }
                }
            }
            .navigationTitle("Demo")
        }
    }
}
