//
//  SelectSubtitleController.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 1.03.2019.
//  Copyright © 2019 Saffet Emin Reisoğlu. All rights reserved.
//

import UIKit
import CoreData

class SelectSubtitleController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate {
    
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
    
    private var detailController: DetailController!
    private var width: CGFloat!
    private var height: CGFloat!
    
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
    
    convenience init(detailController: DetailController, width: CGFloat, height: CGFloat) {
        self.init(nibName:nil, bundle:nil)
        
        self.detailController = detailController
        self.width = width
        self.height = height
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear
        setupView()
        
        closeButton.addTarget(self, action: #selector(handleCloseButton), for: .touchDown)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap))
        singleTap.delegate = self
        self.view.addGestureRecognizer(singleTap)
        
        setUpTheming()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self.view {
            return false
        }
        return true
    }
    
    @objc func handleSingleTap() {
        closeSelectSubtitleController()
    }
    
    private func setupView() {
        self.view.addSubview(generalView)
        generalView.addSubview(label1)
        generalView.addSubview(closeButton)
        closeButton.addSubview(closeImageView)
        generalView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            generalView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            generalView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            generalView.widthAnchor.constraint(equalToConstant: width),
            generalView.heightAnchor.constraint(equalToConstant: height),
            
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
        closeSelectSubtitleController()
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
            detailController.file.video?.subtitle = nil
        } else {
            let newIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            detailController.file.video?.subtitle = subtitleFetchedResultsController.object(at: newIndexPath)
        }
        CoreDataManager.shared.save = true
        detailController.setDetailViewValue()
        closeSelectSubtitleController()
    }
    
    private func closeSelectSubtitleController() {
        if let videoDetailView = detailController.detailView as? VideoDetailView {
            videoDetailView.closeButton.isHidden = false
        }
        self.dismiss(animated: true, completion: nil)
    }

}

extension SelectSubtitleController: Themed {
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
