//
//  UsersListView.swift
//  SwiftUI-Practice
//
//  Created by Naleen Dissanayake on 2026/01/07.
//

import SwiftUI

enum SimulationMode: String, CaseIterable, Identifiable {
    case loaded = "Loaded"
    case empty = "Empty"
    case error = "Error"

    var id: Self { self }
}

enum ViewState: Equatable {
    case idle
    case loading
    case loaded([String])
    case empty
    case failed(message: String)
}

struct UsersListView: View {
    @State private var state: ViewState = .idle
    @State private var mode: SimulationMode = .loaded

    private let sampleUsers = ["Naleen", "Priyanthe", "Nishith", "Sushma", "Sai"]

    var body: some View {
        VStack(spacing: 16) {
            Text("Users")
                .font(.title.weight(.bold))

            Picker("Result", selection: $mode) {
                ForEach(SimulationMode.allCases) { item in
                    Text(item.rawValue).tag(item)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)

            content

            actionButton
        }
        .padding(.vertical)
    }

    @ViewBuilder
    private var content: some View {
        switch state {
        case .idle:
            VStack(spacing: 8) {
                Image(systemName: "person.2")
                    .imageScale(.large)
                Text("Tap Load to fetch users")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loading:
            ProgressView("Loading…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .loaded(let users):
            List(users, id: \.self) { user in
                Text(user)
            }
            .listStyle(.plain)

        case .empty:
            VStack(spacing: 8) {
                Image(systemName: "person.slash")
                    .imageScale(.large)
                Text("No users found")
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .failed(let message):
            VStack(spacing: 8) {
                Image(systemName: "exclamationmark.triangle")
                    .imageScale(.large)
                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    private var actionButton: some View {
        Button {
            load()
        } label: {
            Text(buttonTitle)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(.horizontal)
        .disabled(state == .loading)
    }

    private var buttonTitle: String {
        switch state {
        case .failed: return "Retry"
        case .loading: return "Loading…"
        default: return "Load"
        }
    }

    private func load() {
        Task {
            state = .loading
            try? await Task.sleep(nanoseconds: 1_500_000_000)

            switch mode {
            case .loaded:
                state = .loaded(sampleUsers)
            case .empty:
                state = .empty
            case .error:
                state = .failed(message: "There was an error loading the users.")
            }
        }
    }
}

#Preview {
    UsersListView()
}
