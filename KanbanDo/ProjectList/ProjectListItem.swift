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

             Text(project.content)
                 .font(.callout)
             
             //담당자
             Text("담당자 : \(project.personCharge)")
             
             //참여인원
             Text("참여인원 : \(project.paricipants)")
             
             HStack{
                 Text("기간")
                 Text("\(project.startDate.formatted())")
                 Text("~")
                 Text("\(project.enddate.formatted())")

                 Spacer()

                 Text("참여인원 : \(project.paricipants)")
             }//: HSTACK
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
    ProjectListItem(project: ProjectViewModel().projects[0])
}
