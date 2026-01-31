import Foundation

struct Nft: Codable {
    let id: String
    let name: String?
    let images: [URL]
    let rating: Int?
    let price: Decimal?
    let author: String?
    let website: String?
}
