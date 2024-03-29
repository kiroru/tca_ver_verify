//
//  DemoStore.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import ComposableArchitecture

@Reducer
struct DemoStore {
    @Dependency(\.dismiss) var dismiss

    @ObservableState
    struct State: Equatable {
        var count = 0
    }

    enum Action: Equatable {
        case onTapButton
        case push(Int)
        case dismissButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onTapButton:
                return .send(.push(state.count + 1))
            case .push:
                return .none
            case .dismissButtonTapped:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}
