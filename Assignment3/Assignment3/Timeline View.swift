import SwiftUI

struct TimelineView: View {
    @State private var studySessions: [StudySession] = []

    var body: some View {
        NavigationView {
            List(studySessions) { session in
                HStack {
                    if let image = UIImage(named: session.characterBubble) {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
                    VStack(alignment: .leading) {
                        Text("Study Session")
                            .font(.headline)
                        Text("\(session.timestamp, formatter: DateFormatter.sessionDateFormatter)") // Corrected usage
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Study Sessions")
            .navigationBarItems(trailing: Button(action: {
                let newSession = StudySession(id: UUID(), duration: 60, characterBubble: "character1", timestamp: Date())
                StudySessionManager.shared.saveStudySession(session: newSession)
                studySessions = StudySessionManager.shared.fetchStudySessions()
            }) {
                Image(systemName: "plus")
            })
            .onAppear {
                studySessions = StudySessionManager.shared.fetchStudySessions()
            }
        }
    }
}

extension DateFormatter {
    static var sessionDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
