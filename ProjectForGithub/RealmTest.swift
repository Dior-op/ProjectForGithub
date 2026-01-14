import Foundation
import RealmSwift


class Person: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var age: Int
}
