//
//  ProjectListItem.swift
//  KanbanDo
//
//  Created by 이상민 on 5/2/24.
//

import SwiftUI

struct ProjectListItem: View {
     var project: Project

     var body: some View {
         VStack(alignment: .leading){
             Text(project.title)
                 .font(.title3)

             Divider()

             Text(project.description)
                 .font(.callout)
             
             
             //기간
             HStack{
                 Text("기간")
                 Text("\(project.startDate.formatted())")
                 Text("~")
                 Text("\(project.endDate.formatted())")
             }//: HSTACK
             .padding(.top)
             
             //구성원
             Text("구성원 : \(project.participants.count)명")
         }//: VSTACK
         .font(.caption)
         .padding()
         .frame(height: 200)
         .background(
             RoundedRectangle(cornerRadius: 10)
                 .foregroundStyle(.white)
                 .shadow(color: .gray, radius: 4, x: 1, y: 1)
                 .opacity(0.3)
         )
         .padding(.vertical)
     }
 }

#Preview {
    ProjectListItem(project: Project(id: "a", title: "장보러가기", description: "배추, 양파, 고추, 파, 마늘사오기", startDate: Date(), endDate: Date(), participants: [User(id: "b", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "z", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "m", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "c", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "d", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "e", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "f", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "g", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "h", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "i", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "j", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "k", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil),User(id: "a", email: "aaaa123@gmail.com", username: "aaaa", photoURL: nil)]))
}
