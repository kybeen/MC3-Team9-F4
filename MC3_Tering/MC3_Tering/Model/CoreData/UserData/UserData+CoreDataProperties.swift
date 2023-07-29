//
//  UserData+CoreDataProperties.swift
//  MC3_Tering
//
//  Created by 김동현 on 2023/07/25.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var birthday: Date?
    @NSManaged public var height: Int16
    @NSManaged public var isLeftHand: Bool
    @NSManaged public var sex: Int16
    @NSManaged public var totalPerfectCount: Int16 // 칭호획득 판단을 위해 필요
    @NSManaged public var totalSwingCount: Int16 // 칭호획득 판단을 위해 필요
    @NSManaged public var username: String?
    @NSManaged public var userPerfectRatio: Double // 칭호획득 판단을 위해 필요
    @NSManaged public var userTargetBackStroke: Int16
    @NSManaged public var userTargetForeStroke: Int16
    @NSManaged public var userTitle1: String?
    @NSManaged public var userTitle1_List: NSObject?
    @NSManaged public var userTitle2: String?
    @NSManaged public var userTitle2_List: NSObject?
    @NSManaged public var weight: Int16

}

extension UserData : Identifiable {

}
