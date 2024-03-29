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
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Form {
                Section {
                    Text("\(viewStore.count)")
                }
                Section {
                    Button("Push") {
                        store.send(.onTapButton)
                    }
                    Button("Dismiss") {
                        store.send(.dismissButtonTapped)
                    }
                }
            }
            .navigationTitle("Demo \(viewStore.count)")
        }
    }
}

#Preview {
    DemoView()
}
