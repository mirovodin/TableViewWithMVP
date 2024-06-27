//
//  Created by Dmitriy Mirovodin on 26.06.2024.

import UIKit

protocol ModuleAlphaViewProtocol: AnyObject {
    func update(model: ModuleAlphaView.Model)
    func showError()
    func showEmpty()
    func startLoader()
    func stopLoader()
}

final class ModuleAlphaViewController: UIViewController {
    
    private lazy var customView = ModuleAlphaView(presenter: presenter)
    private let presenter: ModuleAlphaPresenterProtocol
    
    init(presenter: ModuleAlphaPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        title = presenter.title
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .always
        presenter.viewDidLoad()
    }    
}

extension ModuleAlphaViewController: ModuleAlphaViewProtocol {
    func showError() {
        customView.showError()
    }
    
    func showEmpty() {
        customView.showEmpty()
    }
        
    func update(model: ModuleAlphaView.Model) {
        customView.update(model: model)
    }
    
    func startLoader() {
        customView.startLoader()
    }
    
    func stopLoader() {
        customView.stopLoader()
    }
}
