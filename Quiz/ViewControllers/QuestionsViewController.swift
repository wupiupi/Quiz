//
//  ViewController.swift
//  Quiz
//
//  Created by Paul Makey on 6.12.23.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    @IBOutlet var slider: UISlider!
    @IBOutlet var rangedLabels: [UILabel]!
    
    
    // MARK: - Private methods
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var currentAnswers: [Answer] {
        questions[questionIndex].answers
    }
    private var chosenAnswers: [Answer] = []
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
        let answersCountIndex = Float(currentAnswers.count - 1)
        slider.maximumValue = answersCountIndex
        slider.value = answersCountIndex / 2
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.chosenAnswers = chosenAnswers
    }
    
    // MARK: - IB Actions
    @IBAction func singleButtons(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else {return}
        let chosenAnswer = currentAnswers[buttonIndex]
        chosenAnswers.append(chosenAnswer)
        nextQuestion()
    }
    
    @IBAction func multipleButtonDidTapped() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                chosenAnswers.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedButtonDidTapped(_ sender: UIButton) {
        let roundedValue = lrintf(slider.value)
        chosenAnswers.append(currentAnswers[roundedValue])
        nextQuestion()
    }
    
}

// MARK: - Private Methods
private extension QuestionsViewController {
    // Hide all Stack Views
    func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        
        // Set title
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // Get current question
        let currentQuestion = questions[questionIndex]
        
        // Set current question
        questionLabel.text = currentQuestion.title
        
        // Calculate progress for progressView
        let currentProgress = Float(questionIndex) / Float(questions.count)
        
        // Set current progress for progressView
        progressView.setProgress(currentProgress, animated: true)
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    func showCurrentAnswers(for type: QuestionType) {
        switch type {
            case .single: showSingleStackView(with: currentAnswers)
            case .multiple: showMultipleStackView(with: currentAnswers)
            case .ranged: showRangedstackView(with: currentAnswers)
        }
    }
    
    func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden.toggle()
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden.toggle()
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    func showRangedstackView(with answers: [Answer]) {
        rangedStackView.isHidden.toggle()
        
        rangedLabels.first?.text = currentAnswers.first?.title
        rangedLabels.last?.text = currentAnswers.last?.title
    }
    
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
