//
//  WorkOutData+CoreDataProperties.swift
//  MC3_Tering
//
//  Created by 김태형 on 2023/08/31.
//
//

import Foundation
import CoreData


extension WorkOutData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkOutData> {
        return NSFetchRequest<WorkOutData>(entityName: "WorkOutData")
    }

    @NSManaged public var backhandPerfect: Int16
    @NSManaged public var backhandTotalCount: Int16
    @NSManaged public var burningCalories: Int16
    @NSManaged public var forehandPerfect: Int16
    @NSManaged public var forehandTotalCount: Int16
    @NSManaged public var id: Int16
    @NSManaged public var selectedValue: Int16
    @NSManaged public var totalSwingCount: Int16
    @NSManaged public var workoutDate: Date?
    @NSManaged public var workoutTime: Int16

}

extension WorkOutData : Identifiable {

}
