//
//  UserDataModel.swift
//  MC3-F4-DoWonGyoRi
//
//  Created by 김동현 on 2023/07/17.
//

import Foundation

class UserDataModel: ObservableObject {
    static let shared = UserDataModel()
    private init() {
        fetchUserData()
    }
    
    @Published var birthday = Date()
    @Published var height = 170
    @Published var isLeftHand = false
    @Published var sex = 0
    @Published var username = "배승현"
    @Published var userTargetBackStroke = 30
    @Published var userTargetForeStroke = 30
    @Published var userTitle1 = "Title1"
    @Published var userTitle1List = ["열정"]
    @Published var userTitle2 = "Title2"
    @Published var userTitle2List = ["초보"]
    @Published var weight = 60
    @Published public var totalSwingCount = 0
    @Published public var totalPerfectCount = 0
    @Published public var userPerfectRatio = 0.0
    
    private let coreDataManager = CoreDataManager.shared
    
    func fetchUserData() {
        let entityName = "UserData"
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        
        guard let userData = fetchResult.first as? UserData else {
            print("Failed to fetch UserData")
            return
        }
        
        birthday = userData.birthday ?? Date()
        height = Int(userData.height)
        isLeftHand = userData.isLeftHand
        sex = Int(userData.sex)
        username = userData.username ?? ""
        userTargetBackStroke = Int(userData.userTargetBackStroke)
        userTargetForeStroke = Int(userData.userTargetForeStroke)
        userTitle1 = userData.userTitle1 ?? ""
        userTitle1List = userData.userTitle1_List as? [String] ?? []
        userTitle2 = userData.userTitle2 ?? ""
        userTitle2List = userData.userTitle2_List as? [String] ?? []
        weight = Int(userData.weight)
        totalSwingCount = Int(userData.totalSwingCount)
        totalPerfectCount = Int(userData.totalPerfectCount)
        userPerfectRatio = userData.userPerfectRatio
    }
    
    func saveUserData() {
        let entityName = "UserData"
        var userData: UserData?
        
        let fetchResult = coreDataManager.fetch(entityName: entityName)
        if let existingUserData = fetchResult.first as? UserData {
            userData = existingUserData
        } else if let newUserData = coreDataManager.create(entityName: entityName, attributes: [:]) as? UserData {
            userData = newUserData
        }
        
        guard let user = userData else {
            print("Failed to create or find UserData")
            return
        }
        
        user.birthday = birthday
        user.height = Int16(height)
        user.isLeftHand = isLeftHand
        user.sex = Int16(sex)
        user.username = username
        user.userTargetBackStroke = Int16(userTargetBackStroke)
        user.userTargetForeStroke = Int16(userTargetForeStroke)
        user.userTitle1 = userTitle1
        user.userTitle1_List = userTitle1List as NSObject
        user.userTitle2 = userTitle2
        user.userTitle2_List = userTitle2List as NSObject
        user.weight = Int16(weight)
        user.totalSwingCount = Int16(totalSwingCount)
        user.totalPerfectCount = Int16(totalPerfectCount)
        user.userPerfectRatio = userPerfectRatio
        
        coreDataManager.update(object: user)
    }
    
    
    
}
