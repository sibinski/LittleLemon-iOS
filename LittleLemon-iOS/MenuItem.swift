//
//  MenuItem.swift
//  LittleLemon-iOS
//
//  Created by Eugene Sibinski on 08.04.2025.
//

import Foundation

struct MenuItem: Identifiable, Decodable {
    var id: Int
    var title: String
    var image: String
    var price: String
}
