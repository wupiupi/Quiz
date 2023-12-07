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
        let time = ContinuousClock().measure {
            getMostFrequentNumber()
        }
        print(time)
    }
    
    // MARK: - IB Actions
    @IBAction func doneButtonDidTapped() {
        dismiss(animated: true)
    }
}

// MARK: - Private Methods
private extension ResultViewController {
    func getMostFrequentNumber() {
        let persons = chosenAnswers.map { $0.person }
        var personCounter: [Person: Int] = [:]

        for person in persons {
            personCounter[person, default: 0] += 1
        }
        
        let sortedPersonCounter = personCounter.sorted { $0.value > $1.value }
        guard let result = sortedPersonCounter.first?.key else { return }
        
        // Get answer in one string
//        let result = Dictionary(grouping: answers) { $0.person }
//            .sorted { $0.value.count > $1.value.count }.first?.key
        
        setupUI(with: result)
    }
    
    func setupUI(with value: Person) {
        answerLabel.text = "Вы – \(value.rawValue)"
        descriptionLabel.text = value.definition
    }
}
