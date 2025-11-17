//
//  quoteswidget.swift
//  quoteswidget
//
//  Created by Raffaele Barra on 16/11/25.
//


//
//  quoteswidget.swift
//  quoteswidgetExtension
//

import WidgetKit
import SwiftUI
import AppIntents

// MARK: - Timeline Entry
struct QuoteEntry: TimelineEntry {
    let date: Date
    let quote: String
}

// MARK: - Provider
struct QuoteProvider: IntentTimelineProvider {

    typealias Intent = QuoteSelectionIntent
    typealias Entry = QuoteEntry

    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: Date(), quote: "Loading…")
    }

    func getSnapshot(
        for configuration: QuoteSelectionIntent,
        in context: Context,
        completion: @escaping (QuoteEntry) -> Void
    ) {
        completion(QuoteEntry(date: Date(), quote: configuration.quote))
    }

    func getTimeline(
        for configuration: QuoteSelectionIntent,
        in context: Context,
        completion: @escaping (Timeline<QuoteEntry>) -> Void
    ) {
        let entry = QuoteEntry(date: Date(), quote: configuration.quote)
        completion(Timeline(entries: [entry], policy: .never))
    }
}


// MARK: - Widget UI
struct QuoteWidgetEntryView: View {
    let entry: QuoteEntry

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue.opacity(0.2))

            Text(entry.quote)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .containerBackground(.fill.tertiary, for: .widget)
    }
}

// MARK: - Widget Definition
struct QuotesWidget: Widget {
    let kind = "QuotesWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind,
            intent: QuoteSelectionIntent.self,
            provider: QuoteProvider()
        ) { entry in
            QuoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Quotes Widget")
        .description("Displays one of your saved quotes.")
        .supportedFamilies([.systemSmall])
    }
}

