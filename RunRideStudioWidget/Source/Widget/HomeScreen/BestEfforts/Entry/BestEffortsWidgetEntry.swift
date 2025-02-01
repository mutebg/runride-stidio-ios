import WidgetKit

struct BestEffort {
    let label: String
    let time: Double
}

struct BestEffortsWidgetEntry: TimelineEntry {
    let date: Date
    let efforts: [BestEffortData]
    let configuration: BestEffortsWidgetIntent
} 
