//
//  CardsPositionCalculator.swift
//  CardAnimation
//
//  Created by Petre.
//  Copyright © 2019 Petre. All rights reserved.
//

import UIKit
import Foundation

public final class CardsView: UIView {
    private let configuration: CardsViewConfiguration
    private let positionCalculator: CardsPositionCalculator
    private let numberOfSlots: Int
    private var timer: Timer?
    private var currentCard: CardLinkedList?
    private var cardsSlots = [CardSlotView]()
    private lazy var nextSwipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
        gesture.direction = configuration.geometrical.extremePointPosition.nextGestureDirection

        return gesture
    }()
    private lazy var previousSwipeGesture: UISwipeGestureRecognizer = {
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(previousCard))
        gesture.direction = configuration.geometrical.extremePointPosition.previousGestureDirection

        return gesture
    }()
    
    public init(cards: [CardRepresentation], numberOfSlots: Int = 4, configuration: CardsViewConfiguration = .init()) {
        currentCard = CardLinkedList.create(from: cards)
        self.numberOfSlots = max(configuration.slots.min, min(configuration.slots.max, numberOfSlots))
        self.configuration = configuration
        self.positionCalculator = CardsPositionCalculator(configuration: configuration.geometrical)

        super.init(frame: .zero)

        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        setupGestures(type: configuration.general.swipeType)
    }

    deinit {
        currentCard?.previous = nil
        currentCard?.next = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setups
    
    public func show() {
        guard let currentCard = currentCard else { return }
        positionCalculator.setup(superviewSize: bounds.size)
        cardsSlots = createSlots(numberOfSlots: numberOfSlots)
        setupInitialPositions(for: cardsSlots)
        startTimer(duration: currentCard.value.displayTime)
    }
    
    // MARK: - Private functions
    
    @objc private func orientationDidChange() {
        guard !cardsSlots.isEmpty else { return }
        DispatchQueue.main.async {
            self.positionCalculator.setup(superviewSize: self.bounds.size)
            self.setupInitialPositions(for: self.cardsSlots)
        }
    }
        
    private func setupGestures(type: SwipeType) {
        switch type {
        case .autoManual, .manual:
            addGestureRecognizer(nextSwipeGesture)
            addGestureRecognizer(previousSwipeGesture)
        case .automatic:
            return
        }
    }

    // MARK: Timer
    
    private func startTimer(duration: TimeInterval) {
        switch configuration.general.swipeType {
        case .autoManual, .automatic:
            timer?.invalidate()
            let timer = Timer(timeInterval: duration, repeats: false, block: { [weak self] _ in
                self?.nextCard()
            })
            RunLoop.main.add(timer, forMode: .common)
            self.timer = timer
        case .manual:
            return
        }
    }
    
    // MARK: Cards Change
        
    @objc func nextCard() {
        setupNextSlot()
        updatePositionsAnimated(for: cardsSlots)
        startTimer(duration: currentCard?.value.displayTime ?? 0)
        guard let lastSlot = cardsSlots.last else { return }
        moveToExtreme(slot: lastSlot)
    }
    
    @objc func previousCard() {
        setupPreviousSlot()
        updatePositionsAnimated(for: cardsSlots)
        startTimer(duration: currentCard?.value.displayTime ?? 0)
        guard let lastSlot = cardsSlots.last else { return }
        moveToExtreme(slot: lastSlot)
    }
    
    // MARK: Swipe Updates
    
    private func setupNextSlot() {
        guard let card = currentCard?.element(index: numberOfSlots), let slot = cardsSlots.last else { return }
        insertSubview(slot, at: 0)
        slot.setup(card: card.value.create(), overlayConfiguration: card.value.overlayConfiguration)
        slot.layoutIfNeeded()
        cardsSlots.append(cardsSlots.removeFirst())
        currentCard = currentCard?.next
    }

    private func setupPreviousSlot() {
        guard let card = currentCard?.previous, let slot = cardsSlots.popLast() else { return }
        slot.setup(card: card.value.create(), overlayConfiguration: card.value.overlayConfiguration)
        slot.layoutIfNeeded()
        cardsSlots.first?.showOverlay()
        cardsSlots.insert(slot, at: 0)
        addSubview(slot)
        currentCard = card
    }
        
    private func moveToExtreme(slot: CardSlotView) {
        slot.setup(center: positionCalculator.extremePoint)
        updateLayout()
    }
    
    private func updateLayout(animations: (() -> Void)? = nil) {
        let allAnimations: () -> Void = {
            animations?()
            self.layoutIfNeeded()
        }
        UIView.animate(withDuration: configuration.animations.duration,
                       delay: configuration.animations.delay,
                       options: configuration.animations.options,
                       animations: allAnimations)
    }
    
    //MARK: Create Views

    private func createSlots(numberOfSlots: Int) -> [CardSlotView] {
        return (0...numberOfSlots).map { index in
            let slot = createEmptySlot()
            insertSubview(slot, at: 0)
            addConstraints([slot.heightConstraint, slot.widthConstraint,
                            slot.horizontalContraint, slot.verticalConstraint])
            guard let card = currentCard?.element(index: index) else { return slot }
            slot.setup(card: card.value.create(), overlayConfiguration: card.value.overlayConfiguration)
            return slot
        }
    }

    private func createEmptySlot() -> CardSlotView {
        let slot = CardSlotView()
        slot.translatesAutoresizingMaskIntoConstraints = false
        slot.transform = .identity
        slot.layer.cornerRadius = configuration.general.cornerRadius
        slot.clipsToBounds = true
        slot.backgroundColor = .clear

        return slot
    }

    //MARK: Update Stack

    private func setupInitialPositions(for slots: [CardSlotView]) {
        setupFirstSlot(slots.first)
        setupLastSlot(slots.last)
        for index in 0..<slots.count - 1 {
            let slot = slots[index]
            let geometrics = positionCalculator.slotGeometrics(index: index)
            slot.setup(center: geometrics.center)
            slot.setup(size: positionCalculator.slotSize)
            slot.alpha = slotAlpha(index: index)
            slot.transform = geometrics.transform
        }
    }
    
    private func updatePositionsAnimated(for slots: [CardSlotView]) {
        setupFirstSlot(slots.first)
        for index in 0..<slots.count - 1 {
            let slot = slots[index]
            let geometrics = positionCalculator.slotGeometrics(index: index)
            let alpha = slotAlpha(index: index)
            slot.setup(center: geometrics.center)
            let animations: (() -> Void)? = {
                slot.alpha = alpha
                slot.transform = geometrics.transform
            }
            updateLayout(animations: animations)
        }
    }
    
    private func slotAlpha(index: Int) -> CGFloat {
        return 1 - CGFloat(index) * configuration.general.alphaDifference
    }
    
    private func setupFirstSlot(_ slot: CardSlotView?) {
        guard let slot = slot else { return }
        slot.hideOverlay()
        UIView.animate(withDuration: configuration.animations.duration,
                             delay: configuration.animations.delay,
                             options: configuration.animations.options,
                             animations: { slot.alpha = 1 })
    }
    
    private func setupLastSlot(_ slot: CardSlotView?) {
        guard let slot = slot else { return }
        slot.setup(center: positionCalculator.extremePoint)
        slot.setup(size: positionCalculator.slotSize)
    }
}
