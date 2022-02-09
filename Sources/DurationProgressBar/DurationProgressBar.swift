import UIKit

protocol DurationProgressBarDelegate: AnyObject {
    func durationProgressBarDidFinishedProgress(_ durationProgressBar: DurationProgressBar)
}

class DurationProgressBar: UIView {
    var progressView = UIView()
    var progressPercent: Double = 0
    var progressDuration: Double = 0 // total duration in seconds
    var runLoop: CADisplayLink?
    var progressStartTimestamp: CFTimeInterval?
    var delegate: DurationProgressBarDelegate?

    init() {
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        addSubview(progressView)
        progressView.backgroundColor = .durationProgressColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.size.width * CGFloat(progressPercent)
        progressView.frame = CGRect(x: 0, y: 0, width: width, height: frame.size.height)
    }

    func startProgress(duration: Double) {
        endProgress()
        progressDuration = duration
        runLoop = CADisplayLink(target: self, selector: #selector(updateProgress))
        runLoop?.add(to: .main, forMode: .common)
    }

    @objc func updateProgress() {
        guard let timestamp = runLoop?.timestamp else { return }
        if progressStartTimestamp == nil {
            progressStartTimestamp = timestamp
        }

        let progress = timestamp - progressStartTimestamp!
        progressPercent = 1 - (progressDuration - progress) / progressDuration
        setNeedsLayout()

        if progress >= progressDuration {
            endProgress()
            delegate?.durationProgressBarDidFinishedProgress(self)
        }
    }

    func endProgress() {
        runLoop?.invalidate()
        runLoop = nil
        progressStartTimestamp = nil
        progressDuration = 0
        progressPercent = 0
        setNeedsLayout()
    }
}
