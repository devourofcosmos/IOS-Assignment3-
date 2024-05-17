import SwiftUI

struct TimelineView: View {
    @StateObject private var viewModel = StudySessionViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.studySessions, id: \.id) { session in
                HStack {
                    if let characterName = session.characterName, let image = UIImage(named: characterName) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    VStack(alignment: .leading) {
                        Text(session.name ?? "")
                            .font(.headline)
                        Text("\(session.date ?? Date(), formatter: DateFormatter().sessionDateFormatter)")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Study Sessions")
            .navigationBarItems(trailing: Button(action: {
                viewModel.addSession(name: "Study", characterName: "character1") // Replace with selected character name
            }) {
                Image(systemName: "plus")
            })
        }
    }
}

extension DateFormatter {
    var sessionDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
