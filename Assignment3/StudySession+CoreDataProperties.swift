//
//  StudySession+CoreDataProperties.swift
//  Assignment3
//
//  Created by Matthew Cruz on 17/5/2024.
//
//

import Foundation
import CoreData


extension StudySession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudySession> {
        return NSFetchRequest<StudySession>(entityName: "StudySession")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?
    @NSManaged public var characterName: String?

}

extension StudySession : Identifiable {

}
