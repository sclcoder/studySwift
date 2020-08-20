//
//  HomeViewController.swift
//  Qushibake
//
//  Created by 孙春磊 on 2020/8/18.
//  Copyright © 2020 coder. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KakaJSON
import MJRefresh
import Kingfisher


class HomeViewController: UIViewController {

    lazy var tableView = UITableView()
    lazy var items = [Item]()
    static let cellId = "itemcellid"
    var page = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let header = MJRefreshNormalHeader(refreshingBlock: self.loadNewData)
        header.beginRefreshing()
        tableView.mj_header = header
        
        tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: self.loadMoreData)
        
    }
    
    
    func loadNewData(){
        
        AF.request(API.imageRank,parameters: ["page" : 1]).responseJSON {
            [weak self] response in
            // 借用第三方库简化
            guard let dict = response.value else { return }
            let jsons = JSON(dict)["items"].arrayObject
            let models = modelArray(from: jsons!, Item.self)
            self?.items.removeAll()
            self?.items.append(contentsOf: models)
            
            self?.tableView.reloadData()
            self?.tableView.mj_header?.endRefreshing()
            self?.page = 1
        };
        
        /**
         原始写法:
         if let dict = response.value as? [String : Any]{
                      /**
                       as as! as?
                       作用
                          -类型转换
                       区别
                          as  : 一般用来对派生类向基类转换为 向上转换
                          as! : 向下转换，转换失败运行时会报错
                          as? : 向下转换，转换失败会置为nil, 可选类型
                       */
                      if let items = dict["items"] as? [[String: Any]]{
                          print(items);
                      }
                  }
         */
    }
    
    
    func loadMoreData(){
        AF.request(API.imageRank,parameters: ["page" : page + 1]).responseJSON {

            [weak self] response in
            guard let dict = response.value else { return }
            let jsons = JSON(dict)["items"].arrayObject
            let models = modelArray(from: jsons!, Item.self)
            
            self?.items.append(contentsOf: models)
            
            self?.tableView.reloadData()
            self?.tableView.mj_footer?.endRefreshing()
            self?.page += 1
        };
    }
    
    
    
}


extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.mj_footer?.isHidden = items.count == 0
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: Self.cellId)
        if(cell == nil){
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: Self.cellId)
        }
        
        let item = items[indexPath.row]
        cell?.textLabel?.text = item.user.name
        print(item)
        let url = item.user.thumb.replacingOccurrences(of: ".webp", with: ".jpg")
//        let url = item.user.thumb
        cell?.imageView?.kf.setImage(with: URL(string: url))
        return cell!
    }

    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}

