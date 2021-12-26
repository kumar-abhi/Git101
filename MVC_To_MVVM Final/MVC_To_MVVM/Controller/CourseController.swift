//
//  CourseController.swift
//  MVC_To_MVVM
//
//  Created by Abhishek Kumar on 09/12/21.
//

import Combine
import Foundation
import UIKit

class CourseController: UITableViewController {
	
	var courses = [Course]()
	let cellId = "cellId"
	
	private var observer: AnyCancellable?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupNavBar()
		setupTableView()
		fetchData()
	}
	
	fileprivate func fetchData() {
		
		self.observer = Service.shared.fetchCourses()
			.sink { completion in
				switch completion {
				case .finished:
					debugPrint("API call completed...")
				case .failure(let serviceError):
					debugPrint(serviceError)
				}
			} receiveValue: { value in
				self.courses = value
				self.tableView.reloadData()
			}
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return courses.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CourseCell
		cell.course = self.courses[indexPath.row]
		return cell
	}
	
	fileprivate func setupTableView() {
		tableView.register(CourseCell.self, forCellReuseIdentifier: cellId)
		tableView.separatorInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
		tableView.separatorColor = .mainTextBlue
		tableView.backgroundColor = UIColor.rgb(r: 12, g: 47, b: 57)
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 50
		tableView.tableFooterView = UIView()
	}
	
	fileprivate func setupNavBar() {
		navigationItem.title = "Courses"
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.navigationBar.backgroundColor = .yellow
		navigationController?.navigationBar.isTranslucent = false
		navigationController?.navigationBar.barTintColor = UIColor.rgb(r: 50, g: 199, b: 242)
		navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
	}
	
}

class CustomNavigationController: UINavigationController {
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
}

extension UIColor {
	static let mainTextBlue = UIColor.rgb(r: 7, g: 71, b: 89)
	static let highlightColor = UIColor.rgb(r: 50, g: 199, b: 242)
	
	static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
		return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
	}
}
