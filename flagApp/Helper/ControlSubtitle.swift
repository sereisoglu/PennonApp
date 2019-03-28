//
//  ControlSubtitle.swift
//  flagApp
//
//  Created by Saffet Emin Reisoğlu on 27.12.2018.
//  Copyright © 2018 Saffet Emin Reisoğlu. All rights reserved.
//

class ControlSubtitle {
    
    private var file: File!
    private var playerController: PlayerController!
    private var encoding: String.Encoding!
    
    private var subtitleLabel: UILabel?
    private var subtitleLabelHeightConstraint: NSLayoutConstraint?
    private var parsedPayload: NSDictionary?
    private var timer: Timer!
    
    init(file: File, playerController: PlayerController) {
        self.file = file
        self.playerController = playerController
        self.encoding = String.Encoding.init(rawValue: UInt(UInt64(bitPattern: (file.subtitle?.encoding)!)))

        setupSubtitleLabel()
        
        do {
            let contents = try String(contentsOf: URL(fileURLWithPath: file.path!), encoding: self.encoding)
            parsedPayload = parseSubRip(contents)
        } catch let error {
            print("Failed subtitle", error)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1/10, target: self, selector: #selector(addPeriodicNotification), userInfo: nil, repeats: true)
    }
    
    // TODO: kill fonksiyonu cagrilmazsa deinit hicbir zaman cagrilmiyor. Niye?
    func kill() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
//    deinit {
//
//    }
    
    private func setupSubtitleLabel() {
        guard let _ = subtitleLabel else {
            subtitleLabel = UILabel()
            subtitleLabel?.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel?.backgroundColor = UIColor.clear
            subtitleLabel?.textAlignment = .center
            subtitleLabel?.numberOfLines = 0
            subtitleLabel?.font = UIFont.boldSystemFont(ofSize: UI_USER_INTERFACE_IDIOM() == .pad ? 40.0 : 22.0)
            subtitleLabel?.textColor = UIColor.white
            subtitleLabel?.layer.shadowColor = UIColor.black.cgColor
            subtitleLabel?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
            subtitleLabel?.layer.shadowOpacity = 0.9;
            subtitleLabel?.layer.shadowRadius = 1.0;
            subtitleLabel?.layer.shouldRasterize = true;
            subtitleLabel?.layer.rasterizationScale = UIScreen.main.scale
            subtitleLabel?.lineBreakMode = .byWordWrapping
            
            playerController.view.addSubview(subtitleLabel!)
            
            var constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(20)-[l]-(20)-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["l" : subtitleLabel!])
            playerController.view.addConstraints(constraints)
            
            var tempConstraint: String = ""
            if UIDevice.current.userInterfaceIdiom == .phone {
                tempConstraint = "V:[l]-(30)-|"
            } else if UIDevice.current.userInterfaceIdiom == .pad {
                tempConstraint = "V:[l]-(130)-|"
            }
            
            constraints = NSLayoutConstraint.constraints(withVisualFormat: tempConstraint, options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: ["l" : subtitleLabel!])
            playerController.view.addConstraints(constraints)
            subtitleLabelHeightConstraint = NSLayoutConstraint(item: subtitleLabel!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 30.0)
            playerController.view.addConstraint(subtitleLabelHeightConstraint!)
            
            return
        }
    }
    
    private func parseSubRip(_ payload: String) -> NSDictionary? {
        
        do {
            var payload = payload.replacingOccurrences(of: "\n\r\n", with: "\n\n")
            payload = payload.replacingOccurrences(of: "\n\n\n", with: "\n\n")
            payload = payload.replacingOccurrences(of: "\r\n", with: "\n")
            
            let parsed = NSMutableDictionary()

            let regexStr = "(\\d+)\\n([\\d:,.]+)\\s+-{2}\\>\\s+([\\d:,.]+)\\n([\\s\\S]*?(?=\\n{2,}|$))"
            let regex = try NSRegularExpression(pattern: regexStr, options: .caseInsensitive)
            let matches = regex.matches(in: payload, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, payload.count))
            for m in matches {
                
                let group = (payload as NSString).substring(with: m.range)
                
                var regex = try NSRegularExpression(pattern: "^[0-9]+", options: .caseInsensitive)
                var match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
                guard let i = match.first else {
                    continue
                }
                let index = (group as NSString).substring(with: i.range)
                
                regex = try NSRegularExpression(pattern: "\\d{1,2}:\\d{1,2}:\\d{1,2}[,.]\\d{1,3}", options: .caseInsensitive)
                match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
                guard match.count == 2 else {
                    continue
                }
                guard let from = match.first, let to = match.last else {
                    continue
                }
                
                var h: TimeInterval = 0.0, m: TimeInterval = 0.0, s: TimeInterval = 0.0, c: TimeInterval = 0.0
                
                let fromStr = (group as NSString).substring(with: from.range)
                var scanner = Scanner(string: fromStr)
                scanner.scanDouble(&h)
                scanner.scanString(":", into: nil)
                scanner.scanDouble(&m)
                scanner.scanString(":", into: nil)
                scanner.scanDouble(&s)
                scanner.scanString(",", into: nil)
                scanner.scanDouble(&c)
                let fromTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
                
                let toStr = (group as NSString).substring(with: to.range)
                scanner = Scanner(string: toStr)
                scanner.scanDouble(&h)
                scanner.scanString(":", into: nil)
                scanner.scanDouble(&m)
                scanner.scanString(":", into: nil)
                scanner.scanDouble(&s)
                scanner.scanString(",", into: nil)
                scanner.scanDouble(&c)
                let toTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)

                let range = NSMakeRange(0, to.range.location + to.range.length + 1)
                guard (group as NSString).length - range.length > 0 else {
                    continue
                }
                let text = (group as NSString).replacingCharacters(in: range, with: "")
                
                let final = NSMutableDictionary()
                final["from"] = fromTime
                final["to"] = toTime
                final["text"] = text
                parsed[index] = final
                
            }
            return parsed
        } catch {
            return nil
        }
    }

    @objc private func addPeriodicNotification() {
        DispatchQueue.main.async {
            guard let label = self.subtitleLabel else { return }
            
            self.subtitleLabel?.text = self.searchSubtitles(self.parsedPayload, self.playerController.currentTime)

            let baseSize = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
            let rect = label.sizeThatFits(baseSize)
            if label.text != nil {
                self.subtitleLabelHeightConstraint?.constant = rect.height + 5.0
            } else {
                self.subtitleLabelHeightConstraint?.constant = rect.height
            }
        }
    }
    
    private func searchSubtitles(_ payload: NSDictionary?, _ time: TimeInterval) -> String? {
        let predicate = NSPredicate(format: "(%f >= %K) AND (%f <= %K)", time, "from", time, "to")
        guard let values = payload?.allValues, let result = (values as NSArray).filtered(using: predicate).first as? NSDictionary else {
            return nil
        }
        guard let text = result.value(forKey: "text") as? String else {
            return nil
        }
        return text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
}
