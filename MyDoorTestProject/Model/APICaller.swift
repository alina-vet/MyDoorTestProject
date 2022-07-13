//
//  APICaller.swift
//  MyDoorTestProject
//
//  Created by Алина Бондарчук on 08.07.2022.
//

import Foundation

class APICaller {
    
    func fetchData(completion: @escaping (Result <[Door], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now()) {
            let data = [Door(title: "Front door", location: "Home"), Door(title: "Back door", location: "Home"), Door(title: "Kitchen door", location: "Home"), Door(title: "Front door", location: "Office")]
            completion(.success(data))
        }
    }
}
