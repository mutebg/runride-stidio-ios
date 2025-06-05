
import Foundation

struct TriathlonData: Decodable {
    let swim: TriathlonDiscipline
    let ride: TriathlonDiscipline
    let run: TriathlonDiscipline

    struct TriathlonDiscipline: Decodable {
        let distance: Double
        let time: Double
        let activities: Int
    }
}