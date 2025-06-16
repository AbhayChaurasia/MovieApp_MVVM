//
//  AppDelegate.swift
//  MovieAppMVVM
//
//  Created by iMacRaja on 14/06/25.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    // MARK: - Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MovieDB") // must match your .xcdatamodeld file name
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let apiConfig = APIConfiguration(
            baseURL: "https://api.themoviedb.org/3/search/movie",
            apiKey: "b977c6a2bf9a50a38b265a7fd49e4c21"
        )
        let service = TMDbMovieSearchService(config: apiConfig)
        
        let viewModel = SearchMovieViewModel(service: service)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let rootVC = storyboard.instantiateViewController(identifier: "SearchMovieViewController") as! SearchMovieViewController
        let coordinator = SearchCoordinator(navigationController: UINavigationController(rootViewController: rootVC))
        rootVC.viewModel = viewModel
        rootVC.coordinator = coordinator
        window?.rootViewController = coordinator.navigationController
        window?.makeKeyAndVisible()
        
        
        
        
        return true
    }
    
}

extension AppDelegate{
    
    // MARK: - Core Data Save
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("❌ Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
