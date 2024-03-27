//
//  RootStore.swift
//  tca_ver_verify
//
//  Created by sudo takuya on 2024/03/27.
//

import ComposableArchitecture

@Reducer
struct RootStore {
    struct State: Equatable {
        @PresentationState var alert: AlertState<Action.Alert>?
        var count = 0
        var path = StackState<Path.State>()
        
        var presenting: Bool {
            return path.count > 0
        }
    }
    
    enum Action: Equatable {
        case alert(PresentationAction<Alert>)
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
                state.path.append(.demo())
                return .none
            case .selectTab(let tab):
                return .none
            case let .path(action):
                switch action {
                case .element(id: let id, action: .demo(.push(let num))):
                    state.path.append(.demo(.init(count: num)))
                default: break
                }
              return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path()
        }
    }
    
    @Reducer
    struct Path {
        enum State: Equatable {
            case demo(DemoStore.State = .init())
        }
        enum Action: Equatable {
            case demo(DemoStore.Action)
        }
        var body: some Reducer<State, Action> {
            Scope(state: \.demo, action: \.demo) {
                DemoStore()
            }
        }
    }
}
