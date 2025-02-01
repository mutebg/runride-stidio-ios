import SwiftUI
import WidgetKit

struct BestEffortsWidget: Widget {
    let kind: String = "RunRide_BestEfforts_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: BestEffortsWidgetIntent.self,
            provider: BestEffortsWidgetTimelineProvider()
        ) { entry in
            BestEffortsView(efforts: entry.efforts)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Best Efforts Widget")
        .description("Shows your best efforts for running or cycling")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct BestEffortsView: View {
    let efforts: [BestEffortData]
    
    @Environment(\.widgetFamily) var family
    
    private var maxItems: Int {
        switch family {
        case .systemMedium:
            return 12
        default:
            return 9
        }
    }

    private var columns: Int {
        switch family {
  
        case .systemMedium:
            return 4
        default:
            return 3
        }
    }
    
    private var fontSize: CGFloat {
        switch family {
        case .systemMedium:
            return 11
        default:
            return 10
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Best Efforts")
                .font(.footnote)
                .foregroundStyle(.textBrand1)
                .padding(.bottom, 10)
            
            if efforts.isEmpty {
                Text("No efforts recorded")
                    .font(.caption)
            } else {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 0), count: columns), spacing: 0) {
                    ForEach(Array(efforts.prefix(maxItems).enumerated()), id: \.element.label) { index, effort in
                        VStack(alignment: .leading, spacing: 3) {
                            Text(effort.label)
                                .font(.system(size: fontSize))
                            Text(formatTime(effort.time))
                                .font(.system(size: fontSize))
                                .foregroundColor(.accent)
                                .fontWeight(.bold)
                                .lineLimit(1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .frame(maxHeight: .infinity)
                        .padding(.top, 4)
                        .padding(.bottom, index < efforts.prefix(maxItems).count - columns ? 4 : 0)
                        .padding(.leading, index % columns == 0 ? 0 : 4)
                        .padding(.trailing, 4)
                        .overlay(
                            GeometryReader { geometry in
                                Path { path in
                                    // Right border for all except rightmost items
                                    if (index + 1) % columns != 0 {
                                        path.move(to: CGPoint(x: geometry.size.width, y: 0))
                                        path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                                    }
                                    
                                    // Bottom border for all except bottom row items
                                    if index < efforts.prefix(maxItems).count - columns {
                                        path.move(to: CGPoint(x: 0, y: geometry.size.height))
                                        path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                                    }
                                }
                                .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                            }
                        )
                    }
                }
            }
        }.frame(maxWidth: .infinity, // Full Screen Width
            maxHeight: .infinity, // Full Screen Height
            alignment: .topLeading) // Align To top
    }
    
    private func formatTime(_ seconds: Double) -> String {
        let hours = Int(seconds) / 3600
        let minutes = Int(seconds) / 60 % 60
        let seconds = Int(seconds) % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%d:%02d", minutes, seconds)
        }
    }
}

#Preview(as: .systemSmall) {
    BestEffortsWidget()
} timeline: {
    BestEffortsWidgetEntry(
        date: .now,
        efforts: [
            BestEffortData(label: "5K", time: 1200),
            BestEffortData(label: "10K", time: 2400),
            BestEffortData(label: "Half Marathon", time: 5400),
            BestEffortData(label: "Marathon", time: 12600)
        ],
        configuration: .init()
    )
} 
