//
//  CollapsableView.swift
//  KingsTestApp
//
//  Created by Arcani on 25.05.2023.
//

import SwiftUI

struct CollapsableView<Content: View>: View {
    
    // MARK: - Properties
    
    @State private var isCollapsed: Bool = true
    private let title: String
    private let content: Content
    
    
    // MARK: - Init
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    
    
    // MARK: - Subviews
    
    private var chevronButton: some View {
        Button {
            withAnimation(.easeInOut) {
                isCollapsed.toggle()
            }
        } label: {
            Image(systemName: "chevron.down")
                .rotationEffect(.degrees(isCollapsed ? 0 : 180))
        }
    }
    
    
    // MARK: - View Body
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.title3)
                Spacer()
                chevronButton
            }
            .padding()
            
            VStack {
                content
            }
            .padding(.bottom)
            .frame(height: isCollapsed ? 0 : .none)
            .opacity(isCollapsed ? 0 : 1)
            .clipped()
            .transition(.opacity)
        }
        .background(Color.white)
        .cornerRadius(16)
    
    }
}

struct CollapsableView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.gray
            CollapsableView(title: "Test") {
                VStack {
                    Text("Test")
                    Text("Test")
                    Text("Test")
                }
            }
            .padding(.horizontal)
        }
    }
}
