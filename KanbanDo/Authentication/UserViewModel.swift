//
//  UserViewModel.swift
//  KanbanDo
//
//  Created by 이인호 on 5/1/24.
//

import Firebase
import FirebaseFirestore

// 싱글톤 패턴을 구현하여 공유 객체 생성
extension UserViewModel {
    static var shared = UserViewModel()
}

@Observable
class UserViewModel {
    private let dbCollection = Firestore.firestore().collection("users") // Firestore의 users 컬렉션에 접근하기 위해 사용되는 객체
    private(set) var users: [User] // Firestore에 저장된 유저들을 불러와 담는 배열. 외부에서 값 수정이 불가능하도록 private(set) 사용. fetchUser를 통해서만 set 가능
    
    init(users: [User] = []) {
        self.users = users
    }
    
    // Firestore에 유저 데이터 추가
    func addUser(id: String, email: String, username: String, photoURL: URL?) async {
        let user = User(id: id, email: email, username: username, photoURL: photoURL)
            
        do {
            /**
             구글 로그인 시 회원가입이 따로 없음. 따라서 로그인 시에 유저 데이터를 추가해야하는데, 로그인 할때마다 추가되어버리는 문제가 발생
             따라서 추가할 유저가 신규인지 기존 유저인지 파악을 위해 해당 유저가 users 컬렉션에  있는지 없는지를 확인
             */
            let snapshot = try await dbCollection.whereField("id", isEqualTo: id).getDocuments()
            
            if snapshot.isEmpty {
                try dbCollection.addDocument(from: user)
            }
        } catch {
            print("Error adding: \(error.localizedDescription)")
        }
    }
    
    // Firestore에서 모든 데이터 가져오기
    func fetchUsers() async {
        do {
            let snapshot = try await dbCollection.getDocuments()
            
            let users: [User] = snapshot.documents.compactMap { document in
                try? document.data(as: User.self)
            }
            
            // 이메일 알파벳 순으로 정렬
            self.users = users.sorted { $0.email < $1.email }
            
        } catch {
            print("Error fetcing: \(error.localizedDescription)")
        }
    }
}
