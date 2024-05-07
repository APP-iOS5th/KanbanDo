//
//  MyPageView.swift
//  KanbanDo
//
//  Created by mac on 5/1/24.
//

import SwiftUI

struct MyPageView: View {
    
    // MyPage Sheet Trigger
    @Binding var showMyPageSheet: Bool
    
    var authenticationViewModel = AuthenticationViewModel.shared
    
    var body: some View {
        VStack {
            AsyncImage(url: authenticationViewModel.photoURL) { image in
                image
                    .resizable()
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 140, height: 140)
            .padding(.vertical)
            
            Text(authenticationViewModel.username)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(authenticationViewModel.email)
                .tint(.black)
            
            VStack {
                Button {
                    authenticationViewModel.logout()
                    showMyPageSheet = false
                } label: {
                    Text("SignOut")
                }
                .padding(EdgeInsets(top: 5, leading: 14, bottom: 5, trailing: 14))
                .foregroundStyle(.black)
                .border(.black)
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    MyPageView(showMyPageSheet: .constant(true))
}
