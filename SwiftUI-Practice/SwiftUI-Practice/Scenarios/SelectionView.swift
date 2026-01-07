//
//  SelectionView.swift
//  SwiftUI-Practice
//
//  Created by Naleen Dissanayake on 2026/01/07.
//

import SwiftUI

enum Plan: String, CaseIterable, Identifiable {
    case free = "Free"
    case basic = "Basic"
    case pro = "Pro"
    case enterprise = "Enterprise"
    
    var id: String { rawValue }
}

struct SelectionView: View {
    
    @State private var selectedPlan: Plan = .free
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 16) {
            Text("Select Plan")
                .font(.title.bold())
            List(Plan.allCases) { plan in
                Button {
                    selectedPlan = plan
                } label: {
                    HStack {
                        Text(plan.rawValue)
                            .font(.callout)
                            .fontWeight(plan == selectedPlan ? .bold : .regular)
                        Spacer()
                        if plan == selectedPlan {
                            Image(systemName: "checkmark")
                                .imageScale(.medium)
                        }
                    }
                    .contentShape(Rectangle()) // makes whole row tappable
                }
                .buttonStyle(.plain)
                .accessibilityElement(children: .combine)
                .accessibilityLabel(plan.rawValue)
                .accessibilityValue(plan == selectedPlan ? "Selected" : "Not Selected")
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .frame(height: 220) // keeps List from expanding forever in a card
        }
        .padding(20)
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(.background))
        .shadow(color: .black.opacity(0.2) ,radius: 10, x: 0, y: 4)
        .padding()
    }
}

#Preview {
    SelectionView()
}
