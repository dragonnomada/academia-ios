//
//  CaloriappRouter.swift
//  MyCaloriAPP
//
//  Created by User on 23/01/23.
//

import Foundation
import UIKit

class CaloriappRouter: NSObject, UINavigationControllerDelegate {
    
    // Navigation Controller
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    // Interactors
    lazy var userInteractor: UserInteractor = {
        let userInteractor = UserInteractor()
        return userInteractor
    }()
    
    lazy var dietInteractor: DietInteractor = {
        let dietInteractor = DietInteractor()
        return dietInteractor
    }()
    
    // Presenters
    
    lazy var homeTabBarPresenter: HomeTabBarPresenter = {
        let homeTabBarPresenter = HomeTabBarPresenter()
        homeTabBarPresenter.interactor = self.userInteractor
        return homeTabBarPresenter
    }()
    
    lazy var defaultLoginPresenter: DefaultLoginPresenter = {
        let presenter = DefaultLoginPresenter()
        presenter.router = self
        return presenter
    }()
    
    lazy var loginAPresenter: LoginAPresenter = {
        let presenter = LoginAPresenter()
        presenter.router = self
        return presenter
    }()
    
    lazy var loginBpresenter: LoginBPresenter = {
        let presenter = LoginBPresenter()
        presenter.router = self
        return presenter
    }()
    
    lazy var loginPasswordPresenter: LoginPasswordPresenter = {
        let presenter = LoginPasswordPresenter()
        presenter.router = self
        return presenter
    }()
    
    lazy var loginTouchIdPresenter: LoginTouchIdPresenter = {
        let presenter = LoginTouchIdPresenter()
        presenter.router = self
        return presenter
    }()
    
    lazy var signinAPresenter: SigninAPresenter = {
        let presenter = SigninAPresenter()
        presenter.router = self
        return presenter
    }()
    
    lazy var signinBPresenter: SigninBPresenter = {
        let presenter = SigninBPresenter()
        presenter.router = self
        return presenter
    }()
    
    lazy var homePresenter: HomePresenter = {
        let presenter = HomePresenter()
        presenter.router = self
        return presenter
    }()
    
    // Navigations
    
    func openDefaultLogin() {
        
        self.defaultLoginPresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(defaultLoginPresenter.viewController, animated: true)
        
    }
    
    func backToDefaultLogin() {
        self.navigationController.popToRootViewController(animated: true)
    }
    
    func closeDefaultLogin() {
        self.navigationController.popViewController(animated: true)
        self.defaultLoginPresenter.disconnectInteractor()
    }
    
    func openLoginA() {
        self.loginAPresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(loginAPresenter.viewController, animated: true)
    }
    
    func closeLoginA() {
        self.navigationController.popViewController(animated: true)
        self.loginAPresenter.disconnectInteractor()
    }
    
    func openLoginB() {
        self.loginBpresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(loginBpresenter.viewController, animated: true)
    }
    
    func closeLoginB() {
        self.navigationController.popViewController(animated: true)
        self.loginBpresenter.disconnectInteractor()
    }
    
    func openLoginTouchId() {
        self.loginTouchIdPresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(loginTouchIdPresenter.viewController, animated: true)
    }
    
    func closeLoginTouchId() {
        self.navigationController.popViewController(animated: true)
        self.loginTouchIdPresenter.disconnectInteractor()
    }
    
    func openLoginPassword() {
        self.loginPasswordPresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(loginPasswordPresenter.viewController, animated: true)
    }
    
    func closeLoginPassword() {
        self.navigationController.popViewController(animated: true)
        self.loginPasswordPresenter.disconnectInteractor()
    }
    
    func openSigninA() {
        self.signinAPresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(signinAPresenter.viewController, animated: true)
    }
    
    func closeSigninA() {
        self.navigationController.popViewController(animated: true)
        self.signinAPresenter.disconnectInteractor()
    }
    
    func openSigninB() {
        self.signinBPresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(signinBPresenter.viewController, animated: true)
    }
    
    func closeSigninB() {
        self.navigationController.popViewController(animated: true)
        self.signinBPresenter.disconnectInteractor()
    }
    
    func openHome() {
        self.homePresenter.connectInteractor(interactor: self.userInteractor)
        self.navigationController.pushViewController(homePresenter.viewController, animated: true)
    }
    
    func closeHome() {
        self.navigationController.popViewController(animated: true)
        self.homePresenter.disconnectInteractor()
    }
    
    func openHomeTabBar() {
        self.homeTabBarPresenter.connectInteractor(interactor: self.userInteractor)
        //self.navigationController.pushViewController(homeTabBarPresenter.tabBarController, animated: true)
        self.navigationController.setViewControllers([homeTabBarPresenter.tabBarController], animated: true)
    }
    
    func closeHomeTabBar() {
        self.navigationController.popViewController(animated: true)
        self.homeTabBarPresenter.disconnectInteractor()
    }
}
