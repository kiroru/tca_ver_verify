//
//  DemoView.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import SwiftUI
import ComposableArchitecture

struct DemoView: View {
    @State var store = Store(initialState: DemoStore.State()) {
        DemoStore()
    }
    
    var body: some View {
        WithPerceptionTracking {
            Form {
                Section {
                    Text("\(store.count)")
                }
                Section {
                    Button("Push") {
                        store.send(.increment)
                    }
                    Button("Dismiss") {
                        store.send(.dismissButtonTapped)
                    }
                }
            }
            .navigationTitle("Demo")
        }
    }
}

#Preview {
    DemoView()
}
