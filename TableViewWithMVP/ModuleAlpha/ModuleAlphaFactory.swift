//
//  Created by Dmitriy Mirovodin on 26.06.2024.

import UIKit

/// Фабрика для создания модуля Alpha
final class ModuleAlphaFactory {
    
    // В структуре параметры, которые мы хотим передать в модуль.
    struct Context {
        // Тут пусто, наш модуль ничего не получает
    }
    
    func make() -> UIViewController {
        let service = UserService()
        
        let presenter = ModuleAlphaPresenter(
            service: service
        )
        let vc = ModuleAlphaViewController(presenter: presenter)
        
        presenter.view = vc
        
        return vc
    }
}
