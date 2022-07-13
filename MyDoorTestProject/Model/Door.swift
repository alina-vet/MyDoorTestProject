//
//  Door.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 07.07.2022.
//

import Foundation
import UIKit

enum DoorStatus: String {
    case locked = "Locked"
    case unlocked = "Unlocked"
    case unlocking = "Unlocking..."
}

struct Door {
    var title: String
    var location: String
    var status: DoorStatus = .locked
    
    init(title: String, location: String) {
        self.title = title
        self.location = location
    }
}


