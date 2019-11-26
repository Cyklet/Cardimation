//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

class CardLinkedList {
    /// Card information
    let value: CardRepresentation
    
    /// Next element in the linked list
    var next: CardLinkedList?
    
    /// Previous element in the linked list
    weak var previous: CardLinkedList?
    
    init(value: CardRepresentation) {
        self.value = value
    }
    
    /// Get the element relative to the current one on a specified position
    /// - Parameter position: The position of the element relative to the current one
    func element(position: Int) -> CardLinkedList? {
        var currentCard: CardLinkedList? = self
        for _ in 0..<position { currentCard = currentCard?.next }
        return currentCard
    }
    
    /// Return a linked list converted from the array
    /// - Parameter cards: An array of a cards representations
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
