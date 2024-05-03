//
//  ProjectListItem.swift
//  KanbanDo
//
//  Created by 이상민 on 5/2/24.
//

import SwiftUI

struct ProjectListItem: View {
    //MARK: - Property
     var project: Project
    @State private var participantsState = false
    private let dateformat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
     var body: some View {
         VStack(alignment: .leading){
             Text(project.title)
                 .font(.title3)
                 .multilineTextAlignment(.leading)
                 .lineLimit(2)

             Divider()

             Text(project.description)
                 .font(.callout)
                 .multilineTextAlignment(.leading)
                 .lineLimit(2)
                 .padding(.bottom, 10)
             
             
             //기간
             HStack{
                 Image(systemName: "timer")
                 Text("\(project.startDate, formatter: dateformat)")
                 Text("~")
                 Text("\(project.endDate, formatter: dateformat)")
             }//: HSTACK
             
//             Text("참여인원 :")
             //펼치기로 구성원 보기
             DisclosureGroup(
                isExpanded: $participantsState,
                content: {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack{
                            ForEach(project.participants){ user in
                                VStack{
                                    AsyncImage(url: user.photoURL) { image in
                                        image
                                            .resizable()
                                            .clipShape(Circle())
                                            
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 30, height: 30)
                                    Text(user.username)
                                }//: LOOP
                                .frame(width: 50)
                            }//: VSTACK
                        }//: LazyHStack
                    }//: SCROLLVIEW
                    .frame(height: 50)
                    .padding(.top, 10)
                },
                label: {
                    HStack{
                        Image(systemName: "person.3")
                        Text("\(project.participants.count)명")
                    }//: HSTACK
                    .foregroundStyle(.black)
                }
             )
             
         }//: VSTACK
         .font(.caption)
         .padding()
         .frame(height: participantsState ? 260 : 200)
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
    ProjectListItem(project: Project(id: "Hello", title: "Hello", description: "my name is Hello", startDate: Date(), endDate: Date(), participants: [User(id: "a", email: "abcd1234@gmail.com", username: "a1234", photoURL: nil)]))
}
