import Foundation

struct Repository: Decodable {
    var items: [RepositoryDetail]
}

struct RepositoryDetail: Decodable {
    var id: Int
    var name: String
    var updated_at: Date
    var ownerName: OwnerInfo
    var description: String
}

struct OwnerInfo: Decodable {
    var login: String
}