//
//  AuthenticationView.swift
//  KanbanDo
//
//  Created by 이인호 on 5/1/24.
//

import SwiftUI
import GoogleSignInSwift

/**
    로그인 화면
 */
struct LoginView: View {
    var authenticationViewModel = AuthenticationViewModel.shared
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(.all)
            switch authenticationViewModel.state {
            case .busy:
                ProgressView()
            case .signedIn:
                TempView()
            case .signedOut:
                VStack {
                    Text("로그인")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    GoogleSignInButton(style: .wide, action: authenticationViewModel.login)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 50.0))
                        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        .padding()
                }
            }
        }
        .task {
            authenticationViewModel.restorePreviousSignIn()
        }
    }
}

#Preview {
    LoginView()
}
