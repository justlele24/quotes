//
//  WidgetConfigSelectionIntent.swift
//  Quotes1
//
//  Created by Raffaele Barra on 17/11/25.
//


//
//  WidgetConfigSelectionIntent.swift
//  quoteswidgetExtension
//

import AppIntents

/// The intent used to let the user choose *which saved widget config* to show.
struct WidgetConfigSelectionIntent: AppIntent, WidgetConfigurationIntent {

    static var title: LocalizedStringResource = "Select Widget"
    static var description =
        IntentDescription("Choose which custom widget you want to display.")

    /// Instead of selecting by UUID (bad for Intents), we use an index.
    @Parameter(
        title: "Widget",
        default: 0,
        optionsProvider: WidgetIndexOptionsProvider()
    )
    var widgetIndex: Int

    static var parameterSummary: some ParameterSummary {
        Summary("Show widget #\(\.$widgetIndex)")
    }
}

/// Provides a dynamic list of saved widget configurations.
struct WidgetIndexOptionsProvider: DynamicOptionsProvider {

    func results() async throws -> [Int] {
        let configs = SavedWidgetConfigStorage.shared.load()
        guard !configs.isEmpty else { return [0] }
        return Array(0 ..< configs.count)
    }
}
