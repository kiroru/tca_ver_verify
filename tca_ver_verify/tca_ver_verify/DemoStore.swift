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

    struct State: Equatable {
        var count = 0
    }

    enum Action: Equatable {
        case increment
        case push(Int)
        case dismissButtonTapped
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .increment:
                state.count += 1
                return .send(.push(state.count))
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
