//
// Created by Do Vien on 24/12/2022 at 05:11.
//
// Copyright © 2022 CPea2506. All rights reserved.
//

import ArgumentParser
import Foundation

// MARK: - Avent

protocol Avent {
    var day: UInt8 { get }

    init(data: String)
    func part1() -> UInt
    func part2() -> UInt
}

// MARK: - Solution

struct Solution {
    // MARK: Lifecycle

    init?(for event: Avent.Type, withData data: String) {
        (self.event, time) = getTime { event.init(data: data) }
    }

    // MARK: Internal

    func getResult() {
        let (part1, time1) = getTime(for: event.part1)
        let (part2, time2) = getTime(for: event.part2)

        print("""
        Solution for day \(event.day)
        collected data in \(time)ms
        part 1: \(part1) in \(time1)ms
        part 2: \(part2) in \(time2)ms
        """)
    }

    // MARK: Private

    private var event: Avent
    private var time: Double
}

/// Get the time to compute solution
func getTime<T>(for solution: () -> T) -> (T, Double) {
    let clock = ContinuousClock()
    var result: T?
    let time = clock.measure {
        result = solution()
    }

    // SAFETY: result always has value when clock done measuring
    return (result!, Double(time.components.attoseconds) * 0.000000000000001)
}

// MARK: - AOC2022

struct AOC2022: ParsableCommand {
    // MARK: Public

    public static let configuration = CommandConfiguration(abstract: "Avent of Code 2022")

    // MARK: Internal

    func run() throws {
        let mainFile = example ? "example.txt" : "input.txt"

        // temporary hack to get true file path to this project
        let url = URL(fileURLWithPath: #filePath)
            .deletingLastPathComponent()
            .appending(component: "day\(day)/\(mainFile)")

        do {
            let data = try String(contentsOf: url)
            var solution: Solution?

            switch day {
            case 1:
                solution = Solution(for: Day1.self, withData: data)
            default:
                print("Info: not yet implemented")
            }

            if let solution {
                solution.getResult()
            }
        } catch {
            print("Error loading file: 🌶️ \(error)")
        }
    }

    // MARK: Private

    @Argument(help: "AOC Day")
    private var day: UInt8

    @Flag(name: .shortAndLong, help: "Uses example file provided by AOC")
    private var example: Bool = false

    @Flag(name: .shortAndLong, help: "Gets all solutions for all AOC days")
    private var all: Bool = false
}

// MARK: - AventOfCode2022

AOC2022.main()
