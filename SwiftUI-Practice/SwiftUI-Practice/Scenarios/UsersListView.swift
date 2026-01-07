//
//  UsersListView.swift
//  SwiftUI-Practice
//
//  Created by Naleen Dissanayake on 2026/01/07.
//

import SwiftUI

enum LoadState: String, CaseIterable, Identifiable {
    case loading
    case loaded
    case empty
    case error
    
    var id: Self { self }
    
    static var segementedCases: [LoadState] {
        [.loaded, .empty, .error]
    }
}

struct UsersListView: View {
    @State private var loadState: LoadState = .empty
    @State private var selectedSegement: LoadState = .loaded
    
    let users: [String] = ["Naleen", "Priyanthe","Nishith","Sushma","Sai"]
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Users")
                .font(.title)
                .fontWeight(.bold)
            segmentedPicker
            Button(loadState == .error ? "Retry" :"Load") {
                self.loadState = .loading
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.loadState = self.selectedSegement
                }
            }
            Group {
                switch loadState {
                case .loaded:
                    List(users, id: \.self) { user in
                        Text(user)
                    }
                case .loading:
                    ProgressView("Loading...")
                case .empty:
                    HStack {
                        Image(systemName: "person")
                            .imageScale(.medium)
                        Text("No users found")
                    }
                case .error:
                    Text("There was an error loading the users")
                }
            }
        }
    }
    
    var segmentedPicker : some View {
        VStack(spacing: 16) {
            Picker("Load State", selection: $selectedSegement) {
                ForEach(LoadState.segementedCases) { item in
                    Text(item.rawValue.capitalized).tag(item)
                }
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    UsersListView()
}
