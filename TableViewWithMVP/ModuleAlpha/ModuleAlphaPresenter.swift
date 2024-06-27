//
//  Created by Dmitriy Mirovodin on 26.06.2024.

protocol ModuleAlphaPresenterProtocol {
    var title: String { get }
    var analiticScreenName: String { get }
    
    func tapRow(index: Int)
    func viewDidLoad()
}

final class ModuleAlphaPresenter: ModuleAlphaPresenterProtocol {
    
    weak var view: ModuleAlphaViewProtocol?

    var title: String { "Users" }
    var analiticScreenName: String { "users_module_screen_name" }
    
    private let service: UserServiceProtocol
    private var model: [UserModel]?
    private var checkedUserIds = Set<UserId>()
    
    init(service: UserServiceProtocol) {
        self.service = service
    }
    
    func tapRow(index: Int) {
        guard let model = model, model.indices.contains(index) else { return }
        
        let userModel = model[index]
        
        if checkedUserIds.contains(userModel.id) {
            checkedUserIds.remove(userModel.id)
        } else {
            checkedUserIds.insert(userModel.id)
        }
        
        updateUI()
    }
    
    func viewDidLoad() {
        view?.stopLoader()
        service.requestUsers { [weak self] (result: Result<[UserModel], Error>) in
            guard let self else { return }
            view?.stopLoader()
            switch result {
            case let .success(model):
                self.model = model
                updateUI()
            case .failure:
                view?.showError()
            }
        }
    }
}

private extension ModuleAlphaPresenter {
    
    func updateUI() {
        guard let model = model, model.count > 0 else { return }
        
        let items: [ModuleAlphaTableViewCell.Model] = model.map {
            .init(
                title: $0.nickName,
                value: "Name: \($0.name), score: \($0.score), position: \($0.position)",
                isChecked: checkedUserIds.contains($0.id)
            )
        }
        
        let viewModel: ModuleAlphaView.Model = .init(items: items)
        
        view?.update(model: viewModel)
    }
}
