//
//  Project.swift
//  KanbanDo
//
//  Created by 이인호 on 4/30/24.
//

import Foundation

// FireStore에 저장할 데이터 Model
struct Project: Identifiable, Codable, Hashable  {
    /**
     id: 프로젝트 고유 식별자
     title: 프로젝트 제목
     description: 프로젝트 설명
     startDate: 시작일
     endDate: 마감일
     participants: 참여 인원 id가 담긴 배열
     */
    let id: String
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date
    let participants: [String]
}
