//
//  Created by Dmitriy Mirovodin on 26.06.2024.

import UIKit

final class ModuleAlphaView: UIView {

    // Используем typealias, что бы было красиво :)
    typealias Item = ModuleAlphaTableViewCell.Model
    
    // Модель через которую передают все изменения во View/TableView
    struct Model {
        let items: [Item]
    }
    
    private var model: Model?
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(ModuleAlphaTableViewCell.self, forCellReuseIdentifier: ModuleAlphaTableViewCell.id)
        view.separatorInset = .zero
        view.tableFooterView = UIView()
        view.backgroundColor = .systemBackground
        view.separatorStyle = .none
        view.showsVerticalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private let presenter: ModuleAlphaPresenterProtocol

    init(presenter: ModuleAlphaPresenterProtocol) {
        self.presenter = presenter
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(model: Model) {
        self.model = model
        tableView.reloadData()
    }

    func showError() {
        // Показываем View ошибки
    }
    
    func showEmpty() {
        // Показываем какой-то View для Empty state
    }
    
    func startLoader() {
        // Показываем скелетон или лоадер
    }
    
    func stopLoader() {
        // Скрываем все
    }
}

extension ModuleAlphaView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = model, let cell = tableView.dequeueReusableCell(withIdentifier: ModuleAlphaTableViewCell.id) as? ModuleAlphaTableViewCell else {
            return UITableViewCell()
        }
        
        let item = model.items[indexPath.row]
        
        let cellModel = ModuleAlphaTableViewCell.Model(
            title: item.title,
            value: item.value,
            isChecked: item.isChecked
        )
        cell.update(with: cellModel)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ModuleAlphaView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        presenter.tapRow(index: indexPath.row)
    }
}

private extension ModuleAlphaView {
    
    func commonInit() {
        backgroundColor = .systemBackground
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(tableView)
    }

    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
}
