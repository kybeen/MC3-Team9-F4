//
//  DateExtension.swift
//  MC3_Tering
//
//  Created by 김영빈 on 2023/07/31.
//

import Foundation

//MARK: - Date를 입력 받으면 요일을 받아오기 위한 Date 익스텐션
extension Date {
    /**
     정수 값으로 년,월,일을 입력하면 해당하는 Date값을 반환하는 함수
     */
    func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        let finalDate = calendar.date(from: dateComponents)!
        return finalDate
    }
    /**
     정수 값으로 년,월을 입력하면 해당하는 Date값을 반환하는 함수
     */
    func date2(_ year: Int, _ month: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        let finalMonth = calendar.date(from: dateComponents)!
        return finalMonth
    }
    
    /**
     Date 값의 요일을 한글 형식으로 반환하는 함수
     */
    func getWeekday() -> String {
        // 영어 형식 요일로 반환 ex) Mon, Tue, ...
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE" // Use "EEE" for short weekday symbols (e.g., "Sun", "Mon", etc.)
        //        return dateFormatter.string(from: self)
        
        // 한글 형식 요일로 반환 ex) 월, 화, ...
        var engLabel = dateFormatter.string(from: self)
        switch engLabel {
        case "Mon":
            return "월"
        case "Tue":
            return "화"
        case "Wed":
            return "수"
        case "Thu":
            return "목"
        case "Fri":
            return "금"
        case "Sat":
            return "토"
        case "Sun":
            return "일"
        default:
            return ""
        }
    }
    /**
     Date 값의 월을 한글 형식으로 반환하는 함수
     */
    func getMonth() -> String {
        //
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월"
        return dateFormatter.string(from: self)
    }
}
