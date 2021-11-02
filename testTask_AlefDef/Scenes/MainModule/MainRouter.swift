//
//  MainRouter.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//  
//

import UIKit

final class MainRouter {
    var viewController: UIViewController?
}

extension MainRouter: MainRouterInput {
    func showAlert(completion: @escaping() -> Void) {
        let allertController = UIAlertController(title: "После сброса данные не восстановятся", message: "", preferredStyle: .alert)
        allertController.addAction(UIAlertAction(title: "Сбросить данные",
                                                 style: .destructive,
                                                 handler: { action in
            completion()
        }))
        allertController.addAction(UIAlertAction(title: "Отмена",
                                                 style: .default, handler: nil))
        
        viewController?.navigationController?.present(allertController, animated: true, completion: nil)
    }
}
