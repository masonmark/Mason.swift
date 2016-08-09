#if os(macOS)

// ColoredView.swift Created by mason on 2016-08-09.   Copyright © 2016 MASON MARK (.COM). All rights reserved.
//
// ...based on: // NakaharaColoredView.h Created by mason on 2007-01-17. And presumably, soon to featured on John Oliver's "How Is This Still A Thing" segment. But apparently it is: http://stackoverflow.com/questions/2962790/best-way-to-change-the-background-color-for-an-nsview (see the explicit warnings from Apple about not interacting with a view's layer directly... this old fashioned shit still works fine.


import AppKit

class ColoredView: NSView {
    
    var backgroundColor: NSColor
    
    override init(frame: NSRect) {
        backgroundColor = NSColor.white
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        backgroundColor = NSColor.white
        super.init(coder:coder)
    }
    
    override func draw(_ dirtyRect: NSRect) {
        backgroundColor.set()
        NSRectFill(dirtyRect)
    }
    
    override var isOpaque: Bool {
        return true;
    }

}

#endif // os(macOS)
