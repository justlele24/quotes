//
//  AppIntent.swift
//  quoteswidget
//
//  Created by Raffaele Barra on 16/11/25.
//

//
//  AppIntent.swift
//  quoteswidgetExtension
//

import AppIntents
import Foundation

struct QuoteSelectionIntent: WidgetConfigurationIntent {

    static var title: LocalizedStringResource = "Select Quote"
    static var description = IntentDescription("Choose which quote this widget displays.")

    @Parameter(
        title: "Quote",
        default: "No quote selected",
        optionsProvider: QuoteOptionsProvider()
    )
    var quote: String
}

struct QuoteOptionsProvider: DynamicOptionsProvider {

    func results() async throws -> [String] {

        let defaults = UserDefaults(suiteName: "group.com.raffaelebarra.Quotes1")
        let quotes = defaults?.stringArray(forKey: "all_quotes") ?? []

        let reversed = quotes.reversed()
        return Array(reversed)
    }
}
