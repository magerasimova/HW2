//
//  Line.swift
//  HW2
//
//  Created by Майя Герасимова on 01.12.2020.
//

import Foundation

struct Metro: Decodable {
    var lines: [Line]
    var name: String
    var id: String
}

struct Line: Decodable {
    var name: String
    //var order: String
    var stations: [Station]
}

struct Station: Decodable{
    var name: String
    var order: Int
}
