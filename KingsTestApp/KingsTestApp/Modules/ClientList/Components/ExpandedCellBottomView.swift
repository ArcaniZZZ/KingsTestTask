//
//  ExpandedCellBottomView.swift
//  KingsTestApp
//
//  Created by Arcani on 26.05.2023.
//

import SwiftUI

struct ExpandedCellBottomView: View {
    
    // MARK: - Properties
    
    private let creationDate: String?
    private let organizationName: String?
    private let statusCode: String?
    private let phone: String?
    private let mobilePhone: String?
    private let email: String?
    private let navigationAction: () -> Void
    
    
    // MARK: - Init
    
    init(creationDate: String?,
         organizationName: String?,
         statusCode: String?,
         phone: String?,
         mobilePhone: String?,
         email: String?,
         navigationAction: @escaping () -> Void
    ) {
        self.creationDate = creationDate
        self.organizationName = organizationName
        self.statusCode = statusCode
        self.phone = phone
        self.mobilePhone = mobilePhone
        self.email = email
        self.navigationAction = navigationAction
    }
    
    
    // MARK: - View Body
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Group {
                HStack(spacing: 4) {
                    Text(Texts.creationDate)
                        .fontWeight(.bold)
                    Text(creationDate ?? "No data")
                }
                Divider()
                HStack(spacing: 4) {
                    Text(Texts.organizationName)
                        .fontWeight(.bold)
                    Text(organizationName ?? "No data")
                }
                Divider()
                HStack(spacing: 4) {
                    Text(Texts.statusCode)
                        .fontWeight(.bold)
                    Text(statusCode ?? "No data")
                }
            }
            .lineLimit(1)
            
            Group {
                Divider()
                HStack(spacing: 4) {
                    Text(Texts.phone)
                        .fontWeight(.bold)
                    Text(phone ?? "No data")
                }
                Divider()
                HStack(spacing: 4) {
                    Text(Texts.mobilePhone)
                        .fontWeight(.bold)
                    Text(mobilePhone ?? "No data")
                }
                Divider()
                HStack(spacing: 4) {
                    Text(Texts.email)
                        .fontWeight(.bold)
                    Text(email ?? "No data")
                }
                
            }
            .lineLimit(1)
            
            Button {
                navigationAction()
            } label: {
                Text("Show details")
                    .foregroundColor(.accentColor)
                    .font(.callout)
            }
            .padding(.top)

        }
        .padding()
    }
}

struct ExpandedCellBottomView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandedCellBottomView(creationDate: "2023.05.06", organizationName: "Apple Co", statusCode: "S2", phone: "123456789", mobilePhone: "987654321", email: "test@gmail.com", navigationAction: {})
    }
}
