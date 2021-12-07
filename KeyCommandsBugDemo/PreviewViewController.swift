//
//  PreviewViewController.swift
//  KeyCommandsBugDemo
//
//  Created by Natalia Osiecka on 07/12/2021.
//

import QuickLook

final class PreviewViewController: QLPreviewController {

    let items: [PreviewItem]
    var onKeyboardPressTap: ((String) -> Void)?

    init(previewItems: [PreviewItem]) {
        self.items = previewItems
        super.init(nibName: nil, bundle: nil)
        delegate = self
        dataSource = self
    }

    @available(*, unavailable, message: "Use init(items:) method instead.")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onKeyboardPressTap?("\nPreviewViewController: Show")
    }

    override var keyCommands: [UIKeyCommand]? {
        return [
            UIKeyCommand(input: UIKeyCommand.inputUpArrow, modifierFlags: [], action: #selector(upAction)),
            UIKeyCommand(input: UIKeyCommand.inputDownArrow, modifierFlags: [], action: #selector(downAction)),
            UIKeyCommand(input: UIKeyCommand.inputLeftArrow, modifierFlags: [], action: #selector(leftAction)),
            UIKeyCommand(input: UIKeyCommand.inputRightArrow, modifierFlags: [], action: #selector(rightAction))
        ].topPrioritised
    }
}

private extension PreviewViewController {

    @objc func upAction() {
        onKeyboardPressTap?("PreviewViewController: UP")
        currentPreviewItemIndex -= 1
    }

    @objc func downAction() {
        onKeyboardPressTap?("PreviewViewController: DOWN")
        currentPreviewItemIndex += 1
    }

    @objc func leftAction() {
        onKeyboardPressTap?("PreviewViewController: LEFT")
    }

    @objc func rightAction() {
        onKeyboardPressTap?("PreviewViewController: RIGHT")
    }
}

extension PreviewViewController: QLPreviewControllerDataSource {

    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return items.count
    }

    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return items[index]
    }
}

extension PreviewViewController: QLPreviewControllerDelegate {

    func previewControllerDidDismiss(_ controller: QLPreviewController) {
        onKeyboardPressTap?("PreviewViewController: Dismiss\n")
    }
}
