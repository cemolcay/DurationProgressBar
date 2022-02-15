//
//  ViewController.swift
//  DurationProgressBar
//
//  Created by Cem Olcay on 2/9/22.
//

import UIKit

class ViewController: UIViewController {
    let progress = DurationProgressBarView()
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(progress)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        progress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        progress.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        progress.heightAnchor.constraint(equalToConstant: 40).isActive = true
        progress.progressView.backgroundColor = .orange

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: progress.bottomAnchor, constant: 20).isActive = true
        button.setTitle("Start progress", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
    }

    @IBAction func buttonPressed(sender: UIButton) {
        progress.startProgress(duration: 2, from: 0.75)
    }
}
