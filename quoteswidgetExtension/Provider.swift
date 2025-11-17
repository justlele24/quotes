import WidgetKit

struct Provider: AppIntentTimelineProvider {

    typealias Intent = WidgetConfigSelectionIntent

    func placeholder(in context: Context) -> QuoteEntry {
        QuoteEntry(date: .now, config: nil)
    }

    func snapshot(for configuration: WidgetConfigSelectionIntent,
                  in context: Context) async -> QuoteEntry {
        await makeEntry(configuration)
    }

    func timeline(for configuration: WidgetConfigSelectionIntent,
                  in context: Context) async -> Timeline<QuoteEntry> {
        let entry = await makeEntry(configuration)
        return Timeline(entries: [entry], policy: .never)
    }

    // MARK: - Convert selected index → widget config
    private func makeEntry(_ intent: WidgetConfigSelectionIntent) async -> QuoteEntry {
        let configs = SavedWidgetConfigStorage.shared.load()

        guard !configs.isEmpty else {
            return QuoteEntry(date: .now, config: nil)
        }

        let index = min(max(intent.widgetIndex, 0), configs.count - 1)
        return QuoteEntry(date: .now, config: configs[index])
    }
}

