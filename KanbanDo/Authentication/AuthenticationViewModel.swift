//
//  AuthenticationViewModel.swift
//  KanbanDo
//
//  Created by 이인호 on 5/1/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import Firebase
import FirebaseFirestore

extension UIApplication {
    static var currentRootViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive})
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow })
            .first?
            .rootViewController
    }
}

// 싱글톤 패턴을 구현하여 공유 객체 생성
extension AuthenticationViewModel {
    static var shared = AuthenticationViewModel()
}

@Observable
final class AuthenticationViewModel {
    // 유저 상태
    enum State {
        case busy
        case signedIn
        case signedOut
    }
    
    var state: State = .busy
    private var authResult: AuthDataResult? = nil
    var userID: String { authResult?.user.uid ?? "" }
    var username: String { authResult?.user.displayName ?? "" }
    var email: String { authResult?.user.email ?? "" }
    var photoURL: URL? { authResult?.user.photoURL }
    
    private var userViewModel = UserViewModel.shared
    
    func login() {
        state = .busy
        guard let clientID = FirebaseApp.app()?.options.clientID,
              let rootViewController = UIApplication.currentRootViewController else {
            return
        }
        
        let configuration = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = configuration
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController, hint: nil) { result, error in
            if let error {
                print("Error: \(error.localizedDescription)")
            }
            Task {
                await self.signIn(user: result?.user)
            }
        }
    }
    
    private func signIn(user: GIDGoogleUser?) async {
        guard let user, let idToken = user.idToken else {
            state = .signedOut
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: user.accessToken.tokenString)
        
        do {
            authResult = try await Auth.auth().signIn(with: credential)
            state = .signedIn
            
            /**
             구글 로그인 시 유저 정보가 Firebase Authentication에 저장되지만, 보안 정책으로 인해 유저 정보를 가져올 수  없음
             따라서 로그인에 성공한 유저들의 정보(이메일, 이름, 이미지)를 FireStore에 User 컬렉션을 생성해서 저장
             유저들 정보는 팀원 추가 시 가입되어있는 유저 리스트를 보여주기 위해 사용
             */
            await userViewModel.addUser(id: userID, email: email, username: username, photoURL: photoURL)
        } catch {
            state = .signedOut
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error {
                print("Error: \(error.localizedDescription)")
            }
            Task {
                await self.signIn(user: user)
            }
        }
    }
    
    func logout() {
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.disconnect()
        try? Auth.auth().signOut()
        authResult = nil
        state = .signedOut
    }
}
