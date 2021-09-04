//
//  InformationModels.swift
//  Statistics Covid-19
//
//  Created by Сергей Флоря on 09.08.2021.
//

// MARK: - Symptoms

struct SymptomModel {
    var imageAddresses = [String]()

    init() {
        self.imageAddresses.append("Temperature")
        self.imageAddresses.append("Cough")
        self.imageAddresses.append("Fatigue")
        self.imageAddresses.append("Dyspnea")
        self.imageAddresses.append("MusclePain")
    }
}

// MARK: - Recommendations

struct Recommendation {
    var title: String
    var content: String
    var imageAddress: String
}

struct RecommendationModel {
    var recommendations = [Recommendation]() // todo

    init() {
        recommendations.append(Recommendation(title: "Оставайтесь дома",
                                              content: "Карантин - Способ остановить распространение коронавируса",
                                              imageAddress: "StayHome"))

        recommendations.append(Recommendation(title: "Ограничьте личные контакты с людьми",
                                              content: "Меньше контактов - меньше вероятность заражения",
                                              imageAddress: "LimitContacts"))

        recommendations.append(Recommendation(title: "Соблюдайте дистанцию",
                                              content: "На улице постарайтесь держаться на расстоянии 2 метров от окружающих",
                                              imageAddress: "KeepDistance"))

        recommendations.append(Recommendation(title: "Еще чаще мойте руки",
                                              content: "После каждого выхода на улицу обрабатывайте телефон ключи и банковскую карту",
                                              imageAddress: "WashHands"))

        recommendations.append(Recommendation(title: "Используйте средства защиты",
                                              content: "Надевайте маску, если вы чувствуете себя заболевшим",
                                              imageAddress: "MeansOfProtection"))

        recommendations.append(Recommendation(title: "Сохраняйте спокойствие",
                                              content: "Высыпайтесь, ешьте полезное и занимайтесь спортом дома",
                                              imageAddress: "KeepingCalm"))

        recommendations.append(Recommendation(title: "Будьте на связи с близкими",
                                              content: "Говорите с друзьями и близкими, сохраняйте с ними контакт",
                                              imageAddress: "StayConnected"))
    }
}
