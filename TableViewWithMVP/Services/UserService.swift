//
//  Created by Dmitriy Mirovodin on 26.06.2024.
//

import Foundation

protocol UserServiceProtocol {
    func requestUsers(completion: @escaping (Result<[UserModel], Error>) -> ())
}

final class UserService: UserServiceProtocol {
    func requestUsers(completion: @escaping (Result<[UserModel], Error>) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion(.success(Constants.users))
        }
    }
}

private extension UserService {
    enum Constants {
        static let users: [UserModel] = [
            .init(id: "id-125", name: "Alexander James", nickName: "Alex", score: Double.random(in: 30...5_500).rounded(), position: "10 level worker"),
            .init(id: "id-438", name: "Elizabeth Marie", nickName: "Liz", score: Double.random(in: 5_000...10_500).rounded(), position: "Senior chef"),
            .init(id: "id-124", name: "Michael John", nickName: "Mike", score: Double.random(in: 1_000...20_400).rounded(), position: "Lead communication manager"),
            .init(id: "id-132", name: "Katherine Anne", nickName: "Kate", score: Double.random(in: 1_000...30_500).rounded(), position: "Gamer"),
            .init(id: "id-544", name: "Matthew David", nickName: "Matt", score: Double.random(in: 200...16_000).rounded(), position: "Loser"),
            .init(id: "id-155", name: "Jennifer Lynn", nickName: "Jen", score: Double.random(in: 300...10_000).rounded(), position: "Mind changer"),
            .init(id: "id-344", name: "Christopher Paul", nickName: "Chris", score: Double.random(in: 4_000...15_000).rounded(), position: "Sailor"),
            .init(id: "id-542", name: "Rebecca Jane", nickName: "Becky", score: Double.random(in: 6_000...106_000).rounded(), position: "Veterinarian"),
            .init(id: "id-335", name: "William Thomas", nickName: "Will", score: Double.random(in: 100...1_000).rounded(), position: "Designer of light machines"),
            .init(id: "id-997", name: "Margaret Rose", nickName: "Maggie", score: Double.random(in: 1_000...14_000).rounded(), position: "Space traveller"),
            .init(id: "id-323", name: "Goos Rosling", nickName: "Goos", score: Double.random(in: 1_000...14_000).rounded(), position: "Deep Learner"),
            .init(id: "id-665", name: "Hell Hong", nickName: "Davil", score: Double.random(in: 1_000...14_000).rounded(), position: "Devil"),
        ]
    }
}
