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
                 .font(.headline)

             Divider()

             Text(project.content)
                 .font(.callout)

             HStack{
                 Text("기간")
                 Text("\(project.startDate.formatted())")
                 Text("~")
                 Text("\(project.enddate.formatted())")

                 Spacer()

                 Text("참여인원 : \(project.paricipants)")
             }//: HSTACK
             .font(.caption)
         }//: VSTACK
         .padding()
         .frame(height: 150)
         .background(.gray.opacity(0.3))
         .clipShape(RoundedRectangle(cornerRadius: 10))
         .padding(.vertical)
     }
 }

#Preview {
    ProjectListItem(project: ProjectViewModel().projects[0])
}
