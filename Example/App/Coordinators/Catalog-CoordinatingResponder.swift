//
//  Catalog-CoordinatingResponder.swift
//  CoordinatorExample
//
//  Created by Aleksandar Vacić on 17.5.17..
//  Copyright © 2017. Radiant Tap. All rights reserved.
//

import UIKit

//	Page is Swift enum type. As such, it's not representable in the Objective-C
//	and it must be in order to use it as argument of UIResponder method.
//
//	Solution: wrap it inside NSObject subclass.
final class CatalogPageBox: NSObject {
	let unbox: CatalogCoordinator.Page
	init(_ value: CatalogCoordinator.Page) {
		self.unbox = value
	}
}
extension CatalogCoordinator.Page {
	var boxed: CatalogPageBox { return CatalogPageBox(self) }
}



extension UIResponder {

	//	** Data requests by various VCs should bubble up to some of the Coordinators
	//	** which will then contact DataManager, get the data and pass it back


	/// Returns the list of all currently promoted products
	///
	/// - Parameters:
	///   - sender: reference to object who requested data
	///   - completion: Closure to call when data is ready or error occurs
	@objc dynamic func fetchPromotedProducts(onQueue queue: OperationQueue? = nil, sender: Any?, completion: @escaping ([Product], Error?) -> Void ) {
		coordinatingResponder?.fetchPromotedProducts(onQueue: queue, sender: sender, completion: completion)
	}


	@objc dynamic func fetchActiveSeason(onQueue queue: OperationQueue? = nil, sender: Any?, completion: @escaping (Season?, Error?) -> Void ) {
		coordinatingResponder?.fetchActiveSeason(onQueue: queue, sender: sender, completion: completion)
	}

	/// Returns the list of categories in given season. If `season` is `nil`,
	///	it will return categories for the latest season.
	///
	/// - Parameters:
	///   - season: (optional) season
	///   - sender: reference to object who requested data
	///   - completion: Closure to call when data is ready or error occurs
	@objc dynamic func fetchProductCategories(season: Season, onQueue queue: OperationQueue? = nil, sender: Any?, completion: @escaping ([Category], Error?) -> Void ) {
		coordinatingResponder?.fetchProductCategories(season: season, onQueue: queue, sender: sender, completion: completion)
	}



	//	** Switching to different VCs

	@objc dynamic func catalogShowPage(_ page: CatalogPageBox, sender: Any?) {
		coordinatingResponder?.catalogShowPage(page, sender: sender)
	}

	/// Use this method to request display of single product details view
	///
	/// - Parameters:
	///   - product: Product to show
	///   - sender: reference to object who requested the display
	@objc dynamic func showProduct(_ product: Product, sender: Any?) {
		coordinatingResponder?.showProduct(product, sender: sender)
	}
}
