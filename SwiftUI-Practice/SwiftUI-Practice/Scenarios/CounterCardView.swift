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
        VStack(alignment:.center, spacing: 30) {
            Text("Counter")
                .font(.title)
            Spacer()
            Text(value, format: .number)
                .font(.title.bold())
            Spacer()
            buttonView
        }
        .padding()
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
    
    var buttonView: some View {
        HStack {
           Button("-") {
                print("minus")
               decrement()
           }
           .padding()
           .contentShape(Rectangle())
           .font(.system(size: 40, weight: .semibold))
           .foregroundStyle(.red)
            
            Spacer()
            
            Button("+") {
                print("plus")
                increment()
            }
            .padding()
            .contentShape(Rectangle())
            .font(.system(size: 40, weight: .semibold))
            .foregroundStyle(.blue)
        }
    }
    
    private func increment() {
        value += 1
    }
    
    private func decrement() {
        // value must not go below 0
        guard value != 0 else { return }
        value -= 1
    }
}

#Preview {
    CounterCardView()
}
