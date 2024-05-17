import SwiftUI
import CoreData

class StudySessionViewModel: ObservableObject {
    @Published var studySessions: [StudySession] = []
    private let viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = context
        fetchSessions()
    }

    func fetchSessions() {
        let request: NSFetchRequest<StudySession> = StudySession.fetchRequest()
        let sortDescriptor = NSSortDescriptor(keyPath: \StudySession.date, ascending: false)
        request.sortDescriptors = [sortDescriptor]

        do {
            studySessions = try viewContext.fetch(request)
        } catch {
            print("Error fetching study sessions: \(error)")
        }
    }

    func addSession(name: String, characterName: String) {
        let newSession = StudySession(context: viewContext)
        newSession.id = UUID()
        newSession.name = name
        newSession.date = Date()
        newSession.characterName = characterName

        do {
            try viewContext.save()
            fetchSessions()
        } catch {
            print("Error saving new study session: \(error)")
        }
    }
}
