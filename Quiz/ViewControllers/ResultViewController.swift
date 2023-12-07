//
//  ResultViewController.swift
//  Quiz
//
//  Created by Paul Makey on 7.12.23.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    // MARK: - Properties
    var chosenAnswers: [Answer]!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        
        guard let result = getMostFrequentNumber(for: chosenAnswers) else { return }
        
        answerLabel.text = "Вы – \(result.rawValue)"
        descriptionLabel.text = result.definition
    }
    
    // MARK: - IB Actions
    @IBAction func doneButtonDidTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
private extension ResultViewController {
    func getMostFrequentNumber(for answers: [Answer]) -> Person? {
        let persons = answers.map { $0.person }
        var personCounter: [Person: Int] = [:]

        for person in persons {
            personCounter[person] = (personCounter[person] ?? 0) + 1
        }
        
        let sortedPersonCounter = personCounter.sorted { $0.value > $1.value }
        sortedPersonCounter.forEach { print($0.key, $0.value) }
        let result = sortedPersonCounter.first?.key
        
        return result
    }
}
