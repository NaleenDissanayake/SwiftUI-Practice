//
//  CounterCardView.swift
//  SwiftUI-Practice
//
//  Created by Naleen Dissanayake on 2026/01/06.
//

import SwiftUI

struct CounterCardView: View {
  @State private var value: Int = 0
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Counter")
                .font(.title.weight(.semibold))
            Text(value, format: .number)
                .font(.system(size: 56, weight: .bold, design: .rounded))
                .accessibilityLabel("Count")
                .accessibilityLabel("\(value)")
            buttonView
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(.background)
        )
        .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 4)
        .padding()
    }
    
    var buttonView: some View {
        HStack {
            Button {
                decrement()
            } label: {
                Image(systemName: "minus")
                    .font(.system(size: 28, weight: .semibold))
                    .frame(minWidth: 44, minHeight: 44)
            }
            .foregroundStyle(.red)
            .disabled(value == 0)
            .opacity(value == 0 ? 0.35 : 1)
            .accessibilityLabel("Decrement")
            
            Spacer()
            
            Button {
                increment()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .semibold))
                    .frame(minWidth: 44, minHeight: 44)
            }
            .foregroundStyle(.blue)
            .accessibilityLabel("Increment")
        }
    }
    
    private func increment() {
        value += 1
    }
    
    private func decrement() {
        // return max value of the given two values
        value = max(value - 1, 0)
    }
}

#Preview {
    CounterCardView()
}
