//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

class CardLinkedList {
    let value: CardRepresentation
    var next: CardLinkedList?
    weak var previous: CardLinkedList?
    
    init(value: CardRepresentation) {
        self.value = value
    }
    
    func element(index: Int) -> CardLinkedList? {
        var currentCard: CardLinkedList? = self
        for _ in 0..<index { currentCard = currentCard?.next }
        return currentCard
    }
    
    static func create(from cards: [CardRepresentation]) -> CardLinkedList? {
        guard let firstCard = cards.first else { return nil }
        let rootCard = CardLinkedList(value: firstCard)
        var currentCard = rootCard
        cards.dropFirst().forEach {
            let newCard = CardLinkedList(value: $0)
            currentCard.next = newCard
            newCard.previous = currentCard
            currentCard = newCard
        }
        currentCard.next = rootCard
        rootCard.previous = currentCard
        
        return rootCard
    }
}
