//
//  PhoneSelectSubtitleController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 7.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import CoreData

class PhoneSelectSubtitleController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    lazy var subtitleFetchedResultsController: NSFetchedResultsController<File> = {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        let request: NSFetchRequest<File> = File.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "path", ascending: true, selector: #selector(NSString.caseInsensitiveCompare))
        ]
        
        var predicate = NSPredicate(format: "typeName == %@", "subtitle")
        
        request.predicate = predicate
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    private let generalView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select Subtitle"
        return label
    }()
    
    private let tableViewCellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var tableViewCellColor: UIColor = {
        let color = UIColor()
        return color
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12.5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let closeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = #imageLiteral(resourceName: "close_bold")
        return iv
    }()
    
    private let tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    private var phoneDetailController: PhoneDetailController!
    
    convenience init(phoneDetailController: PhoneDetailController) {
        self.init(nibName:nil, bundle:nil)
        
        self.phoneDetailController = phoneDetailController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        setUpTheming()
    }
    
    private func setupView() {
        self.view.addSubview(generalView)
        generalView.addSubview(label1)
        generalView.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        generalView.addSubview(tableView)
        
        
        
        let bounds = UIScreen.main.bounds
        let viewWidth = bounds.width < bounds.height ? bounds.width : bounds.height
        
        // viewVidth * 9/16
        
        NSLayoutConstraint.activate([
            generalView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: viewWidth * 9/16),
            generalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            generalView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            generalView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            
            label1.topAnchor.constraint(equalTo: generalView.topAnchor, constant: 15),
            label1.trailingAnchor.constraint(equalTo: closeButton.leadingAnchor, constant: -20),
            label1.leadingAnchor.constraint(equalTo: generalView.leadingAnchor,constant: 20),
            
            closeButton.centerYAnchor.constraint(equalTo: label1.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -20),
            closeButton.widthAnchor.constraint(equalToConstant: 25),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            
            closeImageView.centerXAnchor.constraint(equalTo: closeButton.centerXAnchor),
            closeImageView.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor),
            closeImageView.widthAnchor.constraint(equalToConstant: 15),
            closeImageView.heightAnchor.constraint(equalTo: closeImageView.widthAnchor),
            
            tableView.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: generalView.bottomAnchor, constant: -20),
            tableView.trailingAnchor.constraint(equalTo: generalView.trailingAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: generalView.leadingAnchor, constant: 10)
            ])
    }
    
    @objc private func handleCloseButton() {
        closePhoneSelectSubtitleController()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (subtitleFetchedResultsController.fetchedObjects?.count)! + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.font = tableViewCellLabel.font
        cell.textLabel?.textColor = tableViewCellLabel.textColor
        cell.backgroundColor = tableViewCellColor
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            cell.textLabel?.text = "Non"
        } else {
            let newIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            let file = subtitleFetchedResultsController.object(at: newIndexPath)
            cell.textLabel?.text = "\(file.name ?? "").\(file.fileExtension ?? "")"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            phoneDetailController.file.video?.subtitle = nil
        } else {
            let newIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            phoneDetailController.file.video?.subtitle = subtitleFetchedResultsController.object(at: newIndexPath)
        }
        CoreDataManager.shared.save = true
        phoneDetailController.setPhoneDetailViewValue()
        closePhoneSelectSubtitleController()
    }
    
    private func closePhoneSelectSubtitleController() {
        if let phoneVideoDetailView = phoneDetailController.phoneDetailView as? PhoneVideoDetailView {
            phoneVideoDetailView.closeButton.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension PhoneSelectSubtitleController: Themed {
    func applyTheme(_ theme: AppTheme) {
        generalView.backgroundColor = theme.backgroundColor
        label1.textColor = theme.primaryColor
        label1.font = theme.header1Font
        closeButton.backgroundColor = theme.primaryColor
        closeImageView.tintColor = theme.tertiaryColor
        tableViewCellColor = theme.backgroundColor
        tableViewCellLabel.textColor = theme.primaryColor
        tableViewCellLabel.font = theme.custom2Font
        tableView.backgroundColor = theme.backgroundColor
        tableView.separatorColor = theme.tertiaryColor
    }
}
