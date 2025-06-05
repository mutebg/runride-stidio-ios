import SwiftUI
import WidgetKit

struct TriathlonView: View {
    let data: TriathlonData
  

    let useMetric = !UserDefaultsConfig.useImperial
    
    var body: some View {
        HStack(spacing: 0) {
            TriathlonDisciplineView(label: "swim", disciplineData: data.swim)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .frame(width: 1)
                .background(Color.gray.opacity(0.2))
                .padding(.horizontal, 12)
            
            TriathlonDisciplineView(label: "ride", disciplineData: data.ride)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .frame(width: 1)
                .background(Color.gray.opacity(0.2))
                .padding(.horizontal, 12)
            
            TriathlonDisciplineView(label: "run", disciplineData: data.run)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
    
    }
}

struct TriathlonDisciplineView: View {
    let label: String
    let disciplineData: TriathlonData.TriathlonDiscipline
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Text(label)
            //     .font(.footnote)
            //     .foregroundColor(.textBrand1)
            Image(label.lowercased())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height:24)
                .foregroundColor(.textBrand1)

            VStack(alignment: .leading, spacing: 0) {
                Text("Distance")
                    .font(.caption)
                    .foregroundStyle(.textBrand1)

                Text("\(disciplineData.distance.distanceInLocalSettings.formatted()) \(DistanceMeasureType.current.title)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.9)
                    .foregroundColor(.accent)
            }
        

            VStack(alignment: .leading, spacing: 0) {
                Text("Time")
                    .font(.caption)
                    .foregroundStyle(.textBrand1)

                Text("\(disciplineData.time.secondsToTimeString)")
                    .font(.system(size: 20))
                .fontWeight(.bold)
                .minimumScaleFactor(0.9)
                .foregroundColor(.accent)
            }
        }
    }
}

#Preview {
    TriathlonView(
        data: TriathlonData(
            swim: TriathlonData.TriathlonDiscipline(distance: 1.5, time: 900, activities: 1),
            ride: TriathlonData.TriathlonDiscipline(distance: 40, time: 7200, activities: 2),
            run: TriathlonData.TriathlonDiscipline(distance: 10, time: 3600, activities: 2)
        ),
       
    )
} 
