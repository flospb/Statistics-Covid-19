//
//  InformationModels.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 09.08.2021.
//

// MARK: - Symptoms

struct SymptomModel {
    static var imageAddresses: [String] = ["Temperature", "Cough", "Fatigue", "Dyspnea", "MusclePain"]
}

// MARK: - Recommendations

struct Recommendation {
    var title: String
    var content: String
    var imageAddress: String
}

struct RecommendationModel {
    static let recommendations: [Recommendation] = [
        Recommendation(title: "Оставайтесь дома",
                       content: "Карантин - Способ остановить распространение коронавируса",
                       imageAddress: "StayHome"),
        Recommendation(title: "Ограничьте личные контакты с людьми",
                       content: "Меньше контактов - меньше вероятность заражения",
                       imageAddress: "LimitContacts"),
        Recommendation(title: "Соблюдайте дистанцию",
                       content: "На улице постарайтесь держаться на расстоянии 2 метров от окружающих",
                       imageAddress: "KeepDistance"),
        Recommendation(title: "Еще чаще мойте руки",
                       content: "После каждого выхода на улицу обрабатывайте телефон ключи и банковскую карту",
                       imageAddress: "WashHands"),
        Recommendation(title: "Используйте средства защиты",
                       content: "Надевайте маску, если вы чувствуете себя заболевшим",
                       imageAddress: "MeansOfProtection"),
        Recommendation(title: "Сохраняйте спокойствие",
                       content: "Высыпайтесь, ешьте полезное и занимайтесь спортом дома",
                       imageAddress: "KeepingCalm"),
        Recommendation(title: "Будьте на связи с близкими",
                       content: "Говорите с друзьями и близкими, сохраняйте с ними контакт",
                       imageAddress: "StayConnected")
    ]
}
