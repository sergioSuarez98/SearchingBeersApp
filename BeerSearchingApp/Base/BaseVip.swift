//
//  BaseVip.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation

protocol BaseInteractorInputProtocol: AnyObject{}
protocol BaseinteractorOutputProtocol: AnyObject{}


class BasePresenter {
    internal var baseInteractor: BaseInteractorInputProtocol?
    required init(){}
}
class BaseInteractor{
    internal var basePresenter: BaseinteractorOutputProtocol?
    required init(){}
}

class BaseCoordinator{
    static func assembly<Presenter: BasePresenter, Interactor: BaseInteractor>(presenter: Presenter.Type, interactor: Interactor.Type) -> (presenter: Presenter, interactor: Interactor) {
        let basePresenter = Presenter()
        let baseInteractor = Interactor()
        basePresenter.baseInteractor = baseInteractor as? BaseInteractorInputProtocol
        baseInteractor.basePresenter = basePresenter as? BaseinteractorOutputProtocol
        
        return (basePresenter,baseInteractor)
    }
}
