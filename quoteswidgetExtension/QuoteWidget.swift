import SwiftUI
import WidgetKit

struct QuoteWidgetEntryView: View {
    let entry: QuoteEntry

    var body: some View {
        if let config = entry.config {
            let s = config.settings
            let font = fontForStyle(s.fontStyle)

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(s.color.color.opacity(s.opacity))

                Text(s.showQuoteMarks ? "❝ \(s.quote) ❞" : s.quote)
                    .font(font)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .containerBackground(.clear, for: .widget)
        } else {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue.opacity(0.2))
                Text("Create widgets in the app.")
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .containerBackground(.clear, for: .widget)
        }
    }
}

struct QuotesWidget: Widget {
    let kind = "QuotesWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: WidgetConfigSelectionIntent.self,
            provider: Provider()
        ) { entry in
            QuoteWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Quotes Widget")
        .description("Displays one of your custom quote widgets.")
        .supportedFamilies([.systemSmall])
    }
}

// Helper shared with the app's font logic
fileprivate func fontForStyle(_ style: String) -> Font {
    switch style {
    case "bold": return .headline
    case "italic": return .body.italic()
    default: return .body
    }
}

