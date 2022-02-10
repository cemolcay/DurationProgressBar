import UIKit

public protocol DurationProgressBarViewDelegate: AnyObject {
    func durationProgressBarDidFinishedProgress(_ durationProgressBar: DurationProgressBarView)
}

public class DurationProgressBarView: UIView {
    public var progressView = UIView()
    public var delegate: DurationProgressBarViewDelegate?

    public private(set) var progressPercent: Double = 0
    private var progressDuration: Double = 0 // total duration in seconds
    private var runLoop: CADisplayLink?
    private var progressStartTimestamp: CFTimeInterval?

    public init() {
        super.init(frame: .zero)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit() {
        addSubview(progressView)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        let width = frame.size.width * CGFloat(progressPercent)
        progressView.frame = CGRect(x: 0, y: 0, width: width, height: frame.size.height)
    }

    public func startProgress(duration: Double, from: Double = 0.0) {
        endProgress()
        progressDuration = duration - (from > duration ? 0 : max(from, 0))
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

    public func endProgress() {
        runLoop?.invalidate()
        runLoop = nil
        progressStartTimestamp = nil
        progressDuration = 0
        progressPercent = 0
        setNeedsLayout()
    }
}
