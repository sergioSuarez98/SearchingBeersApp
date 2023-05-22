//
//  BeerCoordinator.swift
//  BeerSearchingApp
//
//  Created by Sergio Suarez on 22/5/23.
//

import Foundation

import SwiftUI

class BeerCoordinator: BaseCoordinator {
    
    static func buildView() -> BeerListView{
        var view = BeerListView(presenter: BeerPresenter())
        let vip = BaseCoordinator.assembly(presenter: BeerPresenter.self, interactor: BeerInteractor.self)
        view.presenter = vip.presenter
        return view
    }
}
