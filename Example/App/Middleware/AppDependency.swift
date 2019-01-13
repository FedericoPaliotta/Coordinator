//
//  AppDependency.swift
//  CoordinatorExample
//
//  Created by Aleksandar Vacić on 10.5.17..
//  Copyright © 2017. Radiant Tap. All rights reserved.
//

import Foundation
import Coordinator
import CoreData


//	Dummy objects, placeholders for real ones
final class RTCoreDataStack {}
final class Keychain {}

//	Dependency carrier through the app,
//	injected into every Coordinator

struct AppDependency {
	var apiManager: IvkoService?
	var dataManager: DataManager?
	var assetManager: AssetManager?
	var accountManager: AccountManager?
	var cartManager: CartManager?
	var catalogManager: CatalogManager?

	var keychainProvider: Keychain?
	var persistanceProvider: RTCoreDataStack?
	var moc: NSManagedObjectContext?

	init(apiManager: IvkoService? = nil,
	     persistanceProvider: RTCoreDataStack? = nil,
	     dataManager: DataManager? = nil,
	     moc: NSManagedObjectContext? = nil,
	     assetManager: AssetManager? = nil,
	     accountManager: AccountManager? = nil,
	     cartManager: CartManager? = nil,
	     catalogManager: CatalogManager? = nil,
	     keychainProvider: Keychain? = nil)
	{
		self.accountManager = accountManager
		self.assetManager = assetManager
		self.cartManager = cartManager
		self.catalogManager = catalogManager
		self.apiManager = apiManager

		self.keychainProvider = keychainProvider
		self.persistanceProvider = persistanceProvider
		self.dataManager = dataManager
		self.moc = moc
	}
}

final class AppDependencyBox: NSObject {
	let unbox: AppDependency
	init(_ value: AppDependency) {
		self.unbox = value
	}
}

extension AppDependency {
	var boxed: AppDependencyBox { return AppDependencyBox(self) }
}

