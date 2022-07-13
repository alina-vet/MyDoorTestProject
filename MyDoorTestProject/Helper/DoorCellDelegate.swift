//
//  DoorCellDelegate.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 11.07.2022.
//

import Foundation

protocol DoorCellDelegate {
    func cellTapped(cell: DoorTableCell)
    func updateDisplay(cell: DoorTableCell)
}
