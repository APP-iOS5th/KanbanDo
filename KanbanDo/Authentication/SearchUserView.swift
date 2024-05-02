//
//  SearchUserView.swift
//  KanbanDo
//
//  Created by 이인호 on 5/1/24.
//

import SwiftUI

/**
    유저 검색 화면
 */
struct SearchUserView: View {
    var userViewModel = UserViewModel.shared
    
    @State var searchText = ""
    @State var filteredUsers: [User] = []
    @Binding var participants: [User]
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
                        addParticipant(user: user)
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
                filteredUsers = userViewModel.users.filter { $0.email.lowercased().contains(newValue.lowercased()) }
            }
            .navigationTitle("팀원 추가")
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
            .task {
                await userViewModel.fetchUsers()
            }
        }
    }
    
    // 팀원 추가 시 이미 추가된 팀원은 다시 추가할 수 없게 막아놓음
    func addParticipant(user: User) {
        if !participants.contains(user) {
            participants.append(user)
            dismiss()
        }
    }
}

//#Preview {
//    SearchUserView()
//}
