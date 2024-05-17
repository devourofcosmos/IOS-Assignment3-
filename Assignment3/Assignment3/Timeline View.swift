import SwiftUI

struct TimelineView: View {
    @State private var studySessions: [StudySession] = []

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        // Navigate back to the home page
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                           let rootViewController = windowScene.windows.first?.rootViewController as? UINavigationController {
                            rootViewController.popViewController(animated: true)
                        }
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                .zIndex(1)
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
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.vertical, 5)
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
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
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
