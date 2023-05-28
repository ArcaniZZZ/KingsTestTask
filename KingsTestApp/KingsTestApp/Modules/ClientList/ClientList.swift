//
//  ClientList.swift
//  KingsTestApp
//
//  Created by Arcani on 25.05.2023.
//

import SwiftUI

struct ClientList: View {
    
    // MARK: - Properties
    
    @StateObject private var viewModel = ClientListViewModel()
    @State private var isShowingBottomSheet = false
    @State private var tableStyleSwitch = false
    @State private var path: [Client] = []
    
    
    // MARK: - View Body
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Colors.background.ignoresSafeArea()
                
                if tableStyleSwitch {
                    expandableTableView
                } else {
                    horizontallyScrollableTableView
                }
                
            }
            .sheet(isPresented: $isShowingBottomSheet) {
                bottomSheetView
                    .presentationDetents([.fraction(0.8)])
                    .presentationDragIndicator(.visible)
            }
            .navigationTitle("Client List")
            .navigationDestination(for: Client.self) { client in
                ClientDetailView(client: client)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    trailingToolBarItem
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    leadingToolBarItem
                }
            }
            .searchable(text: $viewModel.searchText)
            .searchScopes($viewModel.searchScope) {
                Text("Name").tag(SearchCategory.fullName)
                Text("Phone").tag(SearchCategory.phone)
                Text("Mobile").tag(SearchCategory.mobilePhone)
                Text("Email").tag(SearchCategory.email)
                Text("Company").tag(SearchCategory.company)
            }
        }
    }
}


// MARK: - Subviews
extension ClientList {
    private var trailingToolBarItem: some View {
        Button {
            isShowingBottomSheet.toggle()
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
                .foregroundColor(.accentColor)
        }
    }
    
    private var leadingToolBarItem: some View {
        Button {
            tableStyleSwitch.toggle()
        } label: {
            Image(systemName: "tablecells.badge.ellipsis")
                .foregroundColor(.accentColor)
        }
    }
    
    private var statusMenuButton: some View {
        Menu {
            Button {
                viewModel.statusFilter = .ready
                print(viewModel.statusFilter)
            } label: {
                Text(ClientStatus.ready.rawValue)
            }
            
            Button {
                viewModel.statusFilter = .inProgress
                print(viewModel.statusFilter)
            } label: {
                Text(ClientStatus.inProgress.rawValue)
            }
            
            Button {
                viewModel.statusFilter = .all
                print(viewModel.statusFilter)
            } label: {
                Text(ClientStatus.all.rawValue)
            }
            
        } label: {
            HStack(spacing: 8) {
                Image(systemName: "cross.case")
                    .foregroundColor(.white)
                Text(viewModel.statusFilter.rawValue)
                    .foregroundColor(.white)
                    .fixedSize()
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.accentColor)
            .cornerRadius(16)
        }
    }
    
    private var datePickerView: some View {
        DatePicker(selection: $viewModel.dateFilter, in: ...Date.now, displayedComponents: .date) {
            Text("Select a date")
        }
    }
    
    private var bottomSheetView: some View {
        VStack(spacing: 10) {
            Text("Choose additional filters")
                .padding(.bottom, 20)
                .fontWeight(.heavy)
            datePickerView
            Divider()
            HStack {
                Text("Client's status")
                Spacer()
                statusMenuButton
            }
            Divider()
            
            Group {
                VStack {
                    HStack {
                        Text("Sort by name")
                            .fontWeight(.medium)
                        Spacer()
                    }
                        
                    HStack {
                        Button("Ascending") {
                            viewModel.sortByName(ascendingOrder: true)
                        }.buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button("Descending") {
                            viewModel.sortByName(ascendingOrder: false)
                        }.buttonStyle(.borderedProminent)
                    }
                }
                Divider()
                
                VStack {
                    HStack {
                        Text("Sort by last name")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    HStack {
                        Button("Ascending") {
                            viewModel.sortByLastName(ascendingOrder: true)
                        }.buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button("Descending") {
                            viewModel.sortByLastName(ascendingOrder: false)
                        }.buttonStyle(.borderedProminent)
                    }
                }
                
                Divider()
            }
            
            Group {
                VStack {
                    HStack {
                        Text("Sort by creation date")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    HStack {
                        Button("Ascending") {
                            viewModel.sortByCreationData(ascendingOrder: true)
                        }.buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button("Descending") {
                            viewModel.sortByCreationData(ascendingOrder: false)
                        }.buttonStyle(.borderedProminent)
                    }
                }
                Divider()
                
                VStack {
                    HStack {
                        Text("Sort by status")
                            .fontWeight(.medium)
                        Spacer()
                    }
                    HStack {
                        Button("Ready first") {
                            viewModel.sortByStatus(isReadyFirst: true)
                        }.buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button("Preplacement first") {
                            viewModel.sortByStatus(isReadyFirst: false)
                        }.buttonStyle(.borderedProminent)
                    }
                }
                Divider()
            }
            .padding(.bottom, 10)
            Button("Delete all filters and sorting criteria") {
                viewModel.clearFiltersAndSortingCriteria()
            }
            .buttonStyle(.bordered)

            
        }
        .padding(.horizontal)
    }
    
    private var horizontallyScrollableTableView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.displayedClients) { client in
                    ScrollableRowView(
                        client: client,
                        navigationAction: { path = [client] }
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            }
        }
    }
    
    private var expandableTableView: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.displayedClients) { client in
                    CollapsableView(title: client.fullName) {
                        ExpandedCellBottomView(
                            creationDate: client.created?.formattedDateString(),
                            organizationName: client.clientOrganisation?.name,
                            statusCode: client.fullStatus.statusLabel,
                            phone: client.fixedLinePhone,
                            mobilePhone: client.mobilePhone,
                            email: client.email,
                            navigationAction: { path = [client] }
                        )
                    }
                }
                
            }
        }.padding(.horizontal)
    }
}

struct ClientList_Previews: PreviewProvider {
    static var previews: some View {
        ClientList()
    }
}
