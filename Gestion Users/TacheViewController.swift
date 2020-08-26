//
//  TacheViewController.swift
//  Gestion Users
//
//  Created by basafou on 8/25/20.
//  Copyright © 2020 basafou. All rights reserved.
//

import UIKit

class TacheViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    
    var id_user:Int = 0
    var ListTache = [Tache]()

     let TachesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let activityView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup_table_view()
        setup_activity_view()

        view.backgroundColor = .white
        self.navigationItem.title = "List Taches"
        
        TacheModel().get_taches_by_user(id_user: id_user){(tache: [Tache]) in
            self.ListTache.append(contentsOf: tache)
            self.TachesTableView.reloadData()
            self.activityView.stopAnimating()
            self.TachesTableView.backgroundColor = .white
        }
    }
    
    func setup_activity_view(){
        activityView.center = self.view.center
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }
    
    func setup_table_view(){
        TachesTableView.dataSource = self
        TachesTableView.delegate = self
        //self.TachesTableView.rowHeight = 100
        self.view.addSubview(TachesTableView)
        TachesTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        TachesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        TachesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        TachesTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        self.TachesTableView.separatorColor = UIColor.clear
        TachesTableView.register(TacheCell.self, forCellReuseIdentifier: "cell")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return self.ListTache.count
    }

       // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TachesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TacheCell
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.title.text = ListTache[indexPath.section].title
        if(ListTache[indexPath.section].completed == false){
            cell.completed.textColor = UIColor(named: "incompleted")
            cell.completed.text = "incompleted"
        }
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor(red:211/255, green:211/255, blue:211/255, alpha: 1).cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        
        return cell
    }
}


class TacheCell: UITableViewCell {
    
    let title: UILabel = {
        let title = UILabel()
        title.text = ""
        title.lineBreakMode = NSLineBreakMode.byWordWrapping
        title.isUserInteractionEnabled = true
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let completed:UILabel = {
        let status = UILabel()
        status.text = "completed"
        status.font = UIFont.boldSystemFont(ofSize: 20)
        status.textColor = UIColor(named: "completed")
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    /*let view_cell:UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()*/
    
    let separator:UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setup_element(){
        //addSubview(view_cell)
        addSubview(title)
        addSubview(completed)
        
    //view_cell.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
    //view_cell.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
    //view_cell.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        title.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        title.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 6).isActive = true
        title.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -6).isActive = true
        
        completed.topAnchor.constraint(equalTo: title.bottomAnchor,constant: 5).isActive = true
        completed.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 6).isActive = true
        completed.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -6).isActive = true
        completed.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup_element()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
