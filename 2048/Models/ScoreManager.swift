//
//  ScoreManager.swift
//  2048
//
//  Created by Denis Fouchard on 07/07/2025.
//
import Foundation
class ScoreManager: ObservableObject {
    @Published var bestScore: Int {
        didSet {
            UserDefaults.standard.set(bestScore, forKey: "bestScore")
        }
    }

    init() {
        self.bestScore = UserDefaults.standard.integer(forKey: "bestScore")
    }

    func updateIfBetter(_ newScore: Int) {
        if newScore > bestScore {
            bestScore = newScore
        }
    }
}
