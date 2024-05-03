//
//  SearchManagerView.swift
//  KanbanDo
//
//  Created by 이인호 on 5/3/24.
//

import SwiftUI

struct SearchManagerView: View {
    @State var searchText = ""
    @State var filteredUsers: [User] = []
    @State var participants: [User]
    @Binding var manager: User?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            LazyVStack(alignment: .leading) {
                ForEach(filteredUsers, id: \.self) { user in
                    HStack {
                        AsyncImage(url: user.photoURL) { image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                .frame(width: 50, height: 50)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(user.email)
                    }
                    .onTapGesture {
                        manager = user
                        dismiss()
                    }
                }
                .padding(.leading)
            }
            Spacer()
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "이메일로 검색")
            .textInputAutocapitalization(.never)
            .onChange(of: searchText) { oldValue, newValue in
                filteredUsers = participants.filter { $0.email.lowercased().contains(newValue.lowercased()) }
            }
            .navigationTitle("담당자 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            .font(.headline)
                    }
                }
            }
        }
    }
}

//#Preview {
//    SearchManagerView()
//}
