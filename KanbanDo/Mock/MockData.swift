

import Foundation

struct ProjectDo: Hashable {
    
    enum projectStatus: String {
        case workDo
        case doing
        case done
    }
    
    var title: String
    var description: String
    var status: projectStatus
    var manager: String
    var closingDate: Date
}

extension ProjectDo {
    static let sampleDo: [ProjectDo] = [
        ProjectDo(title: "할일 1", description: "해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.해야하는 일 1입니다.", status: .workDo, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 2", description: "해야하는 일 2입니다.", status: .doing, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 3", description: "해야하는 일 3입니다.", status: .workDo, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 4", description: "해야하는 일 4입니다.", status: .doing, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 5", description: "해야하는 일 5입니다.", status: .doing, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 6", description: "해야하는 일 6입니다.", status: .done, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 7", description: "해야하는 일 7입니다.", status: .workDo, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 8", description: "해야하는 일 6입니다.", status: .done, manager: "김성국", closingDate: Date()),
        ProjectDo(title: "할일 9", description: "해야하는 일 7입니다.", status: .workDo, manager: "김성국", closingDate: Date()),
    ]
}
