//
//  BeerDetailCoordinator.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 23/5/23.
//

import Foundation

import SwiftUI

class BeerDetailCoordinator: BaseCoordinator {
    
    static func buildView() -> BeerDetailView{
        var view = BeerDetailView(id: 41)
        let vip = BaseCoordinator.assembly(presenter: BeerDetailPresenter.self, interactor: BeerDetailInteractor.self)
        view.presenter = vip.presenter
        return view
    }
}
