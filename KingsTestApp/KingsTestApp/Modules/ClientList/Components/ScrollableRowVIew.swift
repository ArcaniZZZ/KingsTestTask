//
//  ScrollableRowVIew.swift
//  KingsTestApp
//
//  Created by Arcani on 26.05.2023.
//

import SwiftUI

struct ScrollableRowView: View {
    
    // MARK: - Properties
    
    private let client: Client
    private let navigationAction: () -> Void
    
    
    // MARK: - Init
    
    init(client: Client, navigationAction: @escaping () -> Void) {
        self.client = client
        self.navigationAction = navigationAction
    }
    
    
    // MARK: - View Body
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 20) {
                Text(client.fullName)
                    .font(.title2)
                    .padding(.trailing)
                  

                Button {
                    navigationAction()
                } label: {
                    Text("Show details")
                        .foregroundColor(.accentColor)
                        .font(.callout)
                }
            }
     
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ColumnView(title: "Created", content: client.created?.formattedDateString())
                    ColumnView(title: "Company", content: client.clientOrganisation?.name)
                    ColumnView(title: "Status", content: client.fullStatus.statusLabel)
                    ColumnView(title: "Phone", content: client.fixedLinePhone)
                    ColumnView(title: "Mobile", content: client.mobilePhone)
                    ColumnView(title: "Email", content: client.email)
                }
            }
        }.frame(height: 100)
    }
}


// MARK: - Subviews
extension ScrollableRowView {
    struct ColumnView: View {
        let title: String
        let content: String?
        
        var body: some View {
            VStack {
                Text(title)
                    .font(.headline)
                Divider()
                Text(content ?? "No Data")
            }
            .padding(.horizontal)
            .cornerRadius(8)
        }
    }
}
