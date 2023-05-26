//
//  ClientDetailView.swift
//  KingsTestApp
//
//  Created by Arcani on 26.05.2023.
//

import SwiftUI

struct ClientDetailView: View {
    
    // MARK: - Properties
    
    private let client: Client
    
    
    // MARK: - Init
    
    init(client: Client) {
        self.client = client
    }
    
    
    // MARK: - View Body

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: "https://picsum.photos/150/150")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .scaleEffect(x: 3, y: 3)
            }
            .frame(width: 150, height: 150)
            .shadow(radius: 10)
            
            ExpandedCellBottomView(
                creationDate: client.created?.formattedDateString(),
                organizationName: client.clientOrganisation?.name,
                statusCode: client.fullStatus.statusLabel,
                phone: client.fixedLinePhone,
                mobilePhone: client.mobilePhone,
                email: client.email,
                navigationAction: {})
            
            Spacer()
        }
        .padding()
    }
}
