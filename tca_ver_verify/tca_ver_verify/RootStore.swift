//
//  RootStore.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import ComposableArchitecture

@Reducer
struct RootStore {
    
    @ObservableState
    struct State: Equatable {
        @Presents var alert: AlertState<Action.Alert>?
        var count = 0
        var path = StackState<Path.State>()
        
        var presenting: Bool {
            return path.count > 0
        }
    }
    
    enum Action {
        case alert(PresentationAction<Alert>)
        @CasePathable
        enum Alert {
            case none
        }
        case selectTab(RootTab)
        case pushNav
        case path(StackAction<Path.State, Path.Action>)
        case onPresent(Bool)
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .pushNav:
                state.path.append(.demo(.init()))
                return .none
            case .selectTab(_):
                return .none
            case let .path(action):
                switch action {
                case .element(id: _, action: .demo(.push(let num))):
                    state.path.append(.demo(.init(count: num)))
                default: break
                }
              return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
    
    @Reducer(state: .equatable)
    enum Path {
        case demo(DemoStore)
    }
}
