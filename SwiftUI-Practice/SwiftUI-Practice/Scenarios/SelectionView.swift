//
//  SelectionView.swift
//  SwiftUI-Practice
//
//  Created by Naleen Dissanayake on 2026/01/07.
//

import SwiftUI

enum Plan: String, CaseIterable {
    case free = "Free"
    case basic = "Basic"
    case pro = "Pro"
    case enterprise = "Enterprise"
}

struct SelectionView: View {
    
    @State private var selectedPlan: Plan = .free
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Select Plan")
                .font(.title.bold())
            List(Plan.allCases, id: \.self) { plan in
                Button(action: { self.selectedPlan = plan }) {
                    HStack {
                        Text(verbatim: plan.rawValue)
                            .font(.callout)
                            .fontWeight(plan == self.selectedPlan ? .bold : .regular)
                            .accessibilityValue("\(plan.rawValue)")
                        Spacer()
                        if plan == self.selectedPlan {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .padding()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(.background))
        .shadow(color: .black.opacity(0.2) ,radius: 10, x: 10, y: 0)
    }
}

#Preview {
    SelectionView()
}
