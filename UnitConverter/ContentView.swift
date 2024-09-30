//
//  ContentView.swift
//  UnitConverter
//
//  Created by Razvan Pricop on 30.09.24.
//

import SwiftUI

enum UnitCategory: String, CaseIterable, Identifiable {
    case length
    case weight
    case volume
    case temperature
    case time
    
    var id: Self { self }
}

enum LengthFormatter: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case meters
    case feet
    case inches
}

enum WeightFormatter: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case kilograms
    case pounds
}

enum VolumeFormatter: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case liters
    case gallons
}

enum TemperatureFormatter: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case celsius
    case fahrenheit
}

enum TimeFormatter: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case seconds
    case minutes
    case hours
    case days
    case weeks
    case months
    case years
}

struct ContentView: View {
    @State var selectedCategory: UnitCategory = .length
    @State var input: Double = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Section("Select a unit category") {
                    Picker("Select a unit category", selection: $selectedCategory) {
                        ForEach(UnitCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("\(selectedCategory.rawValue) conversions")) {
                    switch selectedCategory {
                        case .length:
                            LengthConverterView(input: input)
                        case .weight:
                            WeightConverterView()
                        case .volume:
                            VolumeConverterView()
                        case .temperature:
                            TemperatureConverterView()
                        case .time:
                            TimeConverterView()
                    }
                }
            }
            .navigationTitle("Unit Converter")
        }
    }
}

struct LengthConverterView: View {
    @State var input: Double = 0
    @State var from: LengthFormatter = .meters
    @State var to: LengthFormatter = .feet
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Enter a value to convert")) {
                TextField("Enter a value", value: $input, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Picker("Select from:", selection: $from) {
                ForEach(LengthFormatter.allCases.filter{ $0 != to }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.automatic)
            
            Picker("Select to:", selection: $to) {
                ForEach(LengthFormatter.allCases.filter{ $0 != from }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.automatic)
            .padding(.bottom)
            
            Text("\(input) \(from.rawValue) is \(LengthConverter.convert(input, from: from, to: to)) \(to.rawValue)")
        }
    }
}

struct LengthConverter {
    static func convert(_ input: Double, from: LengthFormatter, to: LengthFormatter) -> String {
        switch (from, to) {
        case (.meters, .feet): return String(input * 3.28084)
        case (.feet, .meters): return String(input / 3.28084)
        case (.meters, .inches): return String(input * 39.3701)
            case (.inches, .meters): return String(input / 39.3701)
        case (.feet, .inches): return String(input * 12)
            case (.inches, .feet): return String(input / 12)
        case (.inches, .inches): return String(input)
        case (.feet, .feet): return String(input)
        case (.meters, .meters): return String(input)
        }
    }
}

struct WeightConverterView: View {
    @State var input: Double = 0
    @State var from: WeightFormatter = .kilograms
    @State var to: WeightFormatter = .pounds
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Enter a value to convert")) {
                TextField("Enter a value", value: $input, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Picker("Select from:", selection: $from) {
                ForEach(WeightFormatter.allCases.filter { $0 != to }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Select to:", selection: $to) {
                ForEach(WeightFormatter.allCases.filter { $0 != from }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Text("\(input) \(from.rawValue) is \(WeightConverter.convert(input, from: from, to: to)) \(to.rawValue)")
        }
    }
}

struct WeightConverter {
    static func convert(_ input: Double, from: WeightFormatter, to: WeightFormatter) -> String {
        switch (from, to) {
        case (.kilograms, .pounds): return String(input * 2.2)
        case (.pounds, .kilograms): return String(input / 2.2)
        case (.kilograms, .kilograms): return String(input)
        case (.pounds, .pounds): return String(input)
        }
    }
}

struct VolumeConverterView: View {
    @State var input: Double = 0
    @State var from: VolumeFormatter = .gallons
    @State var to: VolumeFormatter = .liters
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Enter a value to convert")) {
                TextField("Enter a value", value: $input, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Picker("Select from:", selection: $from) {
                ForEach(VolumeFormatter.allCases.filter { $0 != to }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Select to:", selection: $to) {
                ForEach(VolumeFormatter.allCases.filter { $0 != from }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Text("\(input.formatted()) \(from.rawValue) is \(VolumeConverter.convert(input, from: from, to: to)) \(to.rawValue)")
        }
    }
}

struct VolumeConverter {
    static func convert(_ input: Double, from: VolumeFormatter, to: VolumeFormatter) -> String {
        switch (from, to) {
        case (.liters, .gallons): return String(input * 0.264172)
        case (.gallons, .liters): return String(input / 0.264172)
        case (.liters, .liters): return String(input)
        case (.gallons, .gallons): return String(input)
        }
    }
}

struct TemperatureConverterView: View {
    @State var input: Double = 0
    @State var from: TemperatureFormatter = .fahrenheit
    @State var to: TemperatureFormatter = .celsius
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Enter a value to convert")) {
                TextField("Enter a value", value: $input, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Picker("Select from:", selection: $from) {
                ForEach(TemperatureFormatter.allCases.filter { $0 != to }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Select to:", selection: $to) {
                ForEach(TemperatureFormatter.allCases.filter { $0 != from }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Text("\(input.formatted()) \(from.rawValue) is \(TemperatureConverter.convert(input, from: from, to: to)) \(to.rawValue)")
        }
    }
}

struct TemperatureConverter {
    static func convert(_ input: Double, from: TemperatureFormatter, to: TemperatureFormatter) -> String {
        switch (from, to) {
        case (.celsius, .fahrenheit):
            return String(input * 1.8 + 32)
        case (.fahrenheit, .celsius):
            return String((input - 32) / 1.8)
        case (.celsius, .celsius): return "\(input)"
        case (.fahrenheit, .fahrenheit): return "\(input)"
        }
    }
}

struct TimeConverterView: View {
    @State var input: Double = 0
    @State var from: TimeFormatter = .days
    @State var to: TimeFormatter = .hours
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        Form {
            Section(header: Text("Enter a value to convert")) {
                TextField("Enter a value", value: $input, formatter: formatter)
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            Picker("Select from:", selection: $from) {
                ForEach(TimeFormatter.allCases.filter { $0 != to }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Picker("Select to:", selection: $to) {
                ForEach(TimeFormatter.allCases.filter { $0 != from }) { formatter in
                    Text(formatter.rawValue)
                }
            }
            .pickerStyle(.segmented)
            
            Text("\(input.formatted()) \(from.rawValue) is \(TimeConverter.convert(input, from: from, to: to)) \(to.rawValue)")
        }
    }
}

struct TimeConverter {
    static func convert(_ input: Double, from: TimeFormatter, to: TimeFormatter) -> String {
        switch (from, to) {
        case (.seconds, .minutes):
            return String(format: "%.2f", input / 60)
        case (.seconds, .hours):
            return String(format: "%.2f", input / 3600)
        case (.seconds, .days):
            return String(format: "%.2f", input / 86400)
        case (.seconds, .weeks):
            return String(format: "%.2f", input / 604800)
        case (.seconds, .months):
            return String(format: "%.2f", input / 2592000)
        case (.seconds, .years): return String(format: "%.2f", input / 31556952)
        case (.minutes, .seconds):
            return String(format: "%.2f", input * 60)
        case (.minutes, .hours):
            return String(format: "%.2f", input / 60)
        case (.minutes, .days):
            return String(format: "%.2f", input / 1440)
        case (.minutes, .weeks):
            return String(format: "%.2f", input / 10080)
        case (.minutes, .months):
            return String(format: "%.2f", input / 43200)
        case (.minutes, .years): return String(format: "%.2f", input / 525600)
        case (.hours, .seconds):
            return String(format: "%.2f", input * 3600)
        case (.hours, .minutes):
            return String(format: "%.2f", input * 60)
        case (.hours, .days):
            return String(format: "%.2f", input / 24)
        case (.hours, .weeks):
            return String(format: "%.2f", input / 168)
        case (.hours, .months):
            return String(format: "%.2f", input / 43200)
        case (.hours, .years):
            return String(format: "%.2f", input / 86400)
        case (.days, .seconds):
            return String(format: "%.2f", input * 86400)
        case (.days, .minutes):
            return String(format: "%.2f", input * 1440)
        case (.days, .hours):
            return String(format: "%.2f", input * 24)
        case (.days, .weeks):
            return String(format: "%.2f", input / 7)
        case (.days, .months):
            return String(format: "%.2f", input / 30.4375)
        case (.days, .years):
            return String(format: "%.2f", input / 365.25)
        case (.weeks, .seconds):
            return String(format: "%.2f", input * 604800)
        case (.weeks, .minutes):
            return String(format: "%.2f", input * 10080)
        case (.weeks, .hours):
            return String(format: "%.2f", input * 168)
        case (.weeks, .days):
            return String(format: "%.2f", input * 7)
        case (.weeks, .months):
            return String(format: "%.2f", input * 10080)
        case (.weeks, .years):
            return String(format: "%.2f", input * 52.1303)
        case (.months, .seconds):
            return String(format: "%.2f", input * 2592000)
        case (.months, .minutes):
            return String(format: "%.2f", input * 144000)
        case (.months, .hours):
            return String(format: "%.2f", input * 43200)
        case (.months, .days):
            return String(format: "%.2f", input * 30.4375)
        case (.months, .weeks):
            return String(format: "%.2f", input * 4.3429)
        case (.months, .years):
            return String(format: "%.2f", input / 12)
        case (.years, .seconds):
            return String(format: "%.2f", input * 31556952)
        case (.years, .minutes):
            return String(format: "%.2f", input * 525600)
        case (.years, .hours):
            return String(format: "%.2f", input * 87600)
        case (.years, .days): return String(format: "%.2f", input * 365.25)
        case (.years, .weeks):
            return String(format: "%.2f", input * 52.1303)
        case (.years, .months):
            return String(format: "%.2f", input * 12)
        case (.seconds, .seconds): return String(input)
        case (.minutes, .minutes): return String(input)
        case (.hours, .hours): return String(input)
        case (.days, .days): return String(input)
        case (.weeks, .weeks): return String(input)
        case (.months, .months): return String(input)
        case (.years, .years): return String(input)
        }
    }
}

#Preview {
    ContentView()
}
