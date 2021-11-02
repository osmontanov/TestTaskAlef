//
//  MainContainer.swift
//  testTask_AlefDef
//
//  Created by talgar osmonov on 1/11/21.
//  
//

import UIKit

final class MainContainer {
    let input: MainModuleInput
	let viewController: UIViewController
	private(set) weak var router: MainRouterInput!

	static func assemble(with context: MainContext) -> MainContainer {
        let container = AppDependencies.shared.container
        let router = MainRouter()
        let interactor = MainInteractor()
        let presenter = MainPresenter(router: router, interactor: interactor)
		let viewController = MainViewController()
        viewController.output = presenter

		presenter.view = viewController
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        interactor.infoStorageService = container.resolve(InfoStorageProtocol.self)
        
        router.viewController = viewController

        return MainContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MainModuleInput, router: MainRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct MainContext {
	weak var moduleOutput: MainModuleOutput?
}
