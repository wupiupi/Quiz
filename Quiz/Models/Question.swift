//
//  Question.swift
//  Quiz
//
//  Created by Paul Makey on 7.12.23.
//

struct Question {
    let title: String
    let type: QuestionType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(
                title: "Как с Вашей менталкой?",
                type: .single,
                answers: [
                    Answer(title: "Ужасно", person: .palto),
                    Answer(title: "Нормально", person: .vova),
                    Answer(title: "Все отлично!", person: .eralash),
                    Answer(title: "Все хорошо! (наверно)", person: .marat)
                ]
            ),
            Question(
                title: "Как дела с родителями?",
                type: .multiple,
                answers: [
                    Answer(title: "Проблемы с мамой", person: .palto),
                    Answer(title: "Проблемы с отцом", person: .marat),
                    Answer(title: "Я их люблю", person: .eralash),
                    Answer(title: "Не важно", person: .vova)
                ]
            ),
            Question(
                title: "Есть ли у вас проблемы с агрессией?",
                type: .ranged,
                answers: [
                    Answer(title: "Да", person: .palto),
                    Answer(title: "Вроде нет", person: .vova),
                    Answer(title: "Немного", person: .marat),
                    Answer(title: "Нет", person: .eralash)
                ]
            )
        ]
    }
}

struct Answer {
    let title: String
    let person: Person
}

enum QuestionType {
    case single
    case multiple
    case ranged
}

enum Person: String {
    case marat = "Марат"
    case palto = "Пальто"
    case vova = "Вова адидас"
    case eralash = "Ералаш"
    
    var definition: String {
        switch self {
            case .marat:
                "У вас проблемы с отцом, вам сложно найти настоящего друга, возможно у вас проблемы с агрессией, с ввиду с вами все хорошо, но это не так, вы старайтесь вести себя как можно громче в компаниях, потому что в детстве вам так не хватало внимания"
            case .palto:
                "Мне жаль, жаль что у вас проблемы в семье, у вас большие проблемы с доверием, возможно когда то вас сломали, все думают что у вас совсем нет проблем, но это не так, пожалуйста постарайтесь довериться кому нибудь, не стройте из себя клоуна"
            case .vova:
                "Лучший персонаж сериала хд"
            case .eralash:
                "У вас все хорошо! У вас хорошие отношения с родителями, с вами весело общаться, но мне жаль, жаль что вы слабы.."
        }
    }
}
