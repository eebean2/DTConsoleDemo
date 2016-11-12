//
//  CCConsoleSample.swift
//  ConsoleTest
//
//  Created by Erik Bean on 11/11/16.
//  Copyright © 2016 Erik Bean. All rights reserved.
//

import UIKit

/// The method in which the console will print
@available(iOS 7.0, *)
public enum PrintMethodSample {
    /// Prints to the CCConsole console only
    case `default`
    /// Prints to both consoles
    case both
    /// Acts like a normal print command
    case xcodeOnly
}

@available(iOS 7.0, *)
public class DTConsoleDemo {
    /// The Console
    static let SharedInstance = DTConsoleDemo()
    private var setupComplete = false
    private var visable = false
    private var console: UITextView?
    private var view = UIView()
    
    private init() {}
    
    /// Setup the console for use as it's own view
    ///
    /// - Parameters:
    ///     - view: The view you are attaching the console to
    public func setup(in view: UIView) {
        if Settings.liveOverride {
            SysOverride.prErr("Console is disabled in a live enviroment, to re-enable, in Xcode, change Console.Settings.liveOverride to false")
            return
        }
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        console = UITextView(frame: frame)
        console!.center = view.center
        console!.textColor = Settings.textColor
        #if os(iOS) || os(macOS)
            console!.isEditable = false
        #endif
        console!.backgroundColor = Settings.backgroundColor
        console!.text = "Welcome to \(Bundle.main.infoDictionary![kCFBundleNameKey as String]!)\n\n"
        setupComplete = true
    }
    
    /// Display the console as a popover
    public func display() {
        if !setupComplete {
            SysConsole.prErr("You must complete setup first")
            return
        }
        view.addSubview(console!)
        view.bringSubview(toFront: console!)
        visable = true
    }
    
    /// Close the display
    public func close() {
        if !visable {
            SysOverride.prErr("Console must be in view, call Console.display()")
            return
        }
        console!.removeFromSuperview()
        visable = false
    }
    
    /// Print a message in the console
    ///
    /// Default color is Green (changeable in Settings)
    /// - Parameters:
    ///     - item: The item you wish to print.
    ///     - method: (optional) The method you wish to print the item.
    public func print<Anything>(_ item: Anything, method: PrintMethodSample = .default) {
        if !setupComplete {
            SysConsole.prErr("You must complete setup first")
            return
        }
        if method == .both {
            var current = console!.text!
            current.append(String(describing: item))
            console!.text = current
            SysOverride.prOvr(item)
        } else if method == .xcodeOnly {
            SysOverride.prOvr(item)
        } else if method == .default {
            var current = console!.text!
            current.append(String(describing: item))
            console!.text = current
        }
    }
    
    /// Print an error message in the console
    ///
    /// Default color is Red (changeable in Settings)
    /// - Parameters:
    ///     - item: The item you wish to print.
    ///     - method: (optional) The method you wish to print the item.
    /// - Bug: Warning text is not currently coloring correctly, defaults to Green
    public func printError<Anything>(_ item: Anything, method: PrintMethodSample = .default) {
        if !setupComplete {
            SysOverride.prErr("You must complete setup first")
            return
        }
        if method == .both {
            printError("\"Print Error\" is not fully avalible yet and has been processed as normal text. Sorry for this inconviance.", method: .both)
            
            var current = console!.text!
            current.append(String(describing: item))
            console!.text = current
            SysOverride.prOvr(item)
        } else if method == .xcodeOnly {
            printError("\"Print Error\" is not fully avalible yet and has been processed as normal text. Sorry for this inconviance.", method: .xcodeOnly)
            
            SysOverride.prOvr(item)
        } else if method == .default {
            printError("\"Print Error\" is not fully avalible yet and has been processed as normal text. Sorry for this inconviance.")
            
            var current = console!.text!
            current.append(String(describing: item))
            console!.text = current
        }
    }
    
    /// Console Settings
    public class Settings {
        /// The text color in the console
        ///
        /// Default is Gree
        public static var textColor: UIColor = .green
        /// The error text color in the console
        ///
        /// Default is Red
        /// - Bug: Error text is not currently coloring correctly, defaults to Green
        public static var errorColor: UIColor = .red
        /// The background color in the console
        ///
        /// Default is Black
        public static var backgroundColor: UIColor = .black
        /// Set true for live enviroments
        public static var liveOverride = false
    }
}

internal class SysOverride {
    static func prOvr<t>(_ item: t) {
        print(item)
    }
    
    static func prErr(_ error: String) {
        print(":: Error :: \(error)")
    }
}

