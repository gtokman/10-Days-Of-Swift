//
//  MemoryViewController.swift
//  Project-7-Memory
//
//  Created by g tokman on 4/5/16.
//  Copyright © 2016 garytokman. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    
    // MARK: Properties
    
    private let difficulty: Difficulty
    private var collectionView: UICollectionView!
    private var deck: Deck!
    
    // Init difficulty
    
    init(difficulty: Difficulty) {
        self.difficulty = difficulty
        super.init(nibName: nil, bundle: nil)
     
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
     // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        start()
    }
    
    private func start() {
        deck = createDeck(numCardsNeededDifficulty(difficulty))
        collectionView.reloadData()
    }
    
    private func createDeck(numCards: Int) -> Deck {
        let fullDeck = Deck.full().shuffled()
        let halfDeck = fullDeck.deckOfNumberOfcards(numCards/2)
        
        return (halfDeck + halfDeck).shuffled()
    }
}

// MARK: Setup

private extension MemoryViewController {
    func setup() {
        view.backgroundColor = .greenSea()
        
        // Collection config
        let space: CGFloat = 5
        let (covWidth, covHeight) = collectionViewSizeDifficulty(difficulty, space: space)
        let layout = layoutCardSize(cardSizeDifficulty(difficulty, space: space), space: space)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: covWidth, height: covHeight), collectionViewLayout: layout)
        collectionView.center = view.center
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.scrollEnabled = false
        collectionView.registerClass(CardCell.self, forCellWithReuseIdentifier: "cardCell")
        collectionView.backgroundColor = .clearColor()
        
        self.view.addSubview(collectionView)
    }
    
    func collectionViewSizeDifficulty(difficulty: Difficulty, space: CGFloat) -> (CGFloat, CGFloat) {
        let (columns, rows) = sizeDifficulty(difficulty)
        let (cardWidth, cardHeight) = cardSizeDifficulty(difficulty, space: space)
        
        let covWidth = columns*(cardWidth + 2*space)
        let covHeight = rows*(cardHeight + space)
        
        return (covWidth, covHeight)
    }
    
    func cardSizeDifficulty(difficulty: Difficulty, space: CGFloat) -> (CGFloat, CGFloat) {
        let ratio: CGFloat = 1.452
        
        let (_, rows) = sizeDifficulty(difficulty)
        let cardHeight: CGFloat = view.frame.height/rows - 2*space
        let cardWidth: CGFloat = cardHeight/ratio
        
        return (cardWidth, cardHeight)
    }
    
    func layoutCardSize(cardSize: (cardWidth: CGFloat, cardHeight: CGFloat), space: CGFloat) -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.itemSize = CGSize(width: cardSize.cardWidth, height: cardSize.cardHeight)
        layout.minimumLineSpacing = space
        
        return layout
    }
}

// MARK: Difficulty

private extension MemoryViewController {
    
    func sizeDifficulty(difficulty: Difficulty) -> (CGFloat, CGFloat) {
        switch difficulty {
        case .Easy:
            return (4,3)
        case .Medium:
            return (6, 4)
        case .Hard:
            return (8,4)
        }
    }
    
    func numCardsNeededDifficulty(difficulty: Difficulty) -> Int {
        let (columns, rows) = sizeDifficulty(difficulty)
        
        return Int(columns * rows)
    }
}

// MARK: UICollectionViewDataSource

extension MemoryViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deck.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cardCell", forIndexPath: indexPath) as! CardCell
        
        let card = deck[indexPath.row]
        cell.renderCardName(card.description, backImageNmae: "back")
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension MemoryViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
}



























