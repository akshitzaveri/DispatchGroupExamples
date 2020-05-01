//
//  ViewController.swift
//  DispatchGroupExamples
//
//  Created by Akshit Zaveri on 01/05/20.
//  Copyright © 2020 Akshit Zaveri. All rights reserved.
//

import UIKit
import Alamofire

final class ViewController: UIViewController {

  // 1
  private struct Endpoint {
    static let posts = "http://jsonplaceholder.typicode.com/posts"
    static let comments = "http://jsonplaceholder.typicode.com/comments"
  }

  // 2
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

  // 3
  private var startTimeInterval: TimeInterval?

  // 4
  private var isWaiting = false {
    didSet {
      self.updateUI()
    }
  }

  // 5
  override func viewDidLoad() {
    super.viewDidLoad()

    self.isWaiting = true

    // Step1: Call posts API
    AF.request(Endpoint.posts).response { response in

      // Step2: Call comments API
      AF.request(Endpoint.comments).response { response in

        // Step3: Update the UI
        self.isWaiting = false
      }
    }
  }

  // 6
  private func updateUI() {
    if self.isWaiting {
      self.startTimeInterval = Date().timeIntervalSinceReferenceDate
      self.label.text = "Waiting for APIs"
      self.activityIndicatorView.startAnimating()
    } else {
      let delta = Date().timeIntervalSinceReferenceDate - self.startTimeInterval! // Don't use force casting in production
      self.label.text = "Responses received in \(delta)"
      self.activityIndicatorView.stopAnimating()
    }
  }
}
