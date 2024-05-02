//
//  User.swift
//  KanbanDo
//
//  Created by 이인호 on 5/1/24.
//

import Foundation

// FireStore에 저장할 User Model
struct User: Identifiable, Codable, Hashable  {
    /**
     id: 유저 고유 식별자(Firebase Authentication에 생성된 UID값)
     email: 구글 계정 이메일
     username: 구글 계정 이름
     photoURL: 구글 계정 이미지
     */
    let id: String
    let email: String
    let username: String
    let photoURL: URL?
}
