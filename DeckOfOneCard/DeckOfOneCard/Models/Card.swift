//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Michael Nguyen on 11/17/20.
//

import Foundation

struct Card: Decodable {
    let value: String
    let suit: String
    let image: URL

}
struct TopLevelObject: Decodable {
    let cards: [Card]
}
