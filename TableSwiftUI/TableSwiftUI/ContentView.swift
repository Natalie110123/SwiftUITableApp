//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Leal, Natalie M on 3/25/26.
//

import SwiftUI
import MapKit

let pastelPink = Color(red: 1.0, green: 0.85, blue: 0.9)
let pastelBlue = Color(red: 0.8, green: 0.9, blue: 1.0)
let pastelPurple = Color(red: 0.9, green: 0.85, blue: 1.0)
let pastelGreen = Color(red: 0.85, green: 1.0, blue: 0.9)
let pastelYellow = Color(red: 1.0, green: 0.97, blue: 0.8)
let pastelMint = Color(red: 0.8, green: 0.97, blue: 0.95)

let data = [
    Item(name: "Best Western", category: "Near Texas State University", price: "$119", desc: "A reliable and affordable choice just minutes from the Texas State campus. This hotel offers rooms with a microwave, refrigerator, and premium cable TV with HBO. Start your morning with a complimentary grab and go breakfast before heading out to the university or the nearby San Marcos River. Amenities include an outdoor pool with sun loungers, a 24-hour business center, and free high speed internet.", address: "917 North Interstate 35 San Marcos, TX", lat: 29.8836, long: -97.9414, imageName: "hotel2"),
    Item(name: "Fairfield Inn & Suites by Marriott", category: "Near Texas State University", price: "$129", desc: "Experience a seamless blend of style and function. This Marriott property features an outdoor swimming pool and a modern fitness center to keep you active. Guests enjoy a complimentary hot breakfast daily, featuring a variety of healthy and savory options. Each room is equipped with a work area, comfy chair, and high speed Wi-Fi, making it perfect for both business travelers and university visitors.", address: "1250 North IH-35 San Marcos, TX", lat: 29.8910, long: -97.9397, imageName: "hotel"),
    Item(name: "Comfort Suites", category: "Near Texas State University", price: "$139", desc: "Comfort Suites provides a luxurious and comfortable feel at an economical price. Each suite features a separate sitting area with a sofa bed, perfect for families or groups. You'll enjoy a free hot breakfast buffet every morning. Features an outdoor swimming pool and a fitness center. Guests stay connected with free high speed Wi-Fi, while in room perks like premium bedding ensure a restful night's sleep.", address: "104 IH 35 North San Marcos, TX", lat: 29.8878, long: -97.9405, imageName: "hotel6"),
    Item(name: "Holiday Inn", category: "Pet Friendly", price: "$149", desc: "This Holiday Inn is a top choice for travelers with furry friends. The pet friendly policy allows for both dogs and cats, with a dedicated grassy area for relief on site. Guests can dine at the Spring Bistro & Bar, which serves breakfast and dinner daily. Relax by the outdoor pool and hot tub or use the fitness center. The rooms offers personalized comfort, alongside refrigerators and TVs with premium channels. An EV charging station is also available for guest use.", address: "105 Bintu Drive San Marcos, TX", lat: 29.8885, long: -97.9387, imageName: "hotel3"),
    Item(name: "Candlewood Suites", category: "Pet Friendly", price: "$159", desc: "Designed for extended stays, Candlewood Suites offers the comforts of home with full sized kitchens in every suite, including a stovetop, dishwasher, and full refrigerator. This pet friendly hotel also allows all guests to bring their furry friends. You can enjoy amenities like free guest laundry facilities, an outdoor pool, and an on site gym, making it ideal for longer trips.", address: "600 Wonder World Dr San Marcos, TX", lat: 29.8619, long: -97.9493, imageName: "hotel4"),
    Item(name: "Embassy Suites by Hilton", category: "Pet Friendly", price: "$189", desc: "Perfect for a shopping getaway, this upscale all suite hotel is located near the San Marcos Premium Outlets. After a full day of browsing designer brands and incredible deals, return to your spacious two room suite featuring a separate living area and private bedroom for ultimate comfort. Relax by the outdoor pool, enjoy a meal at the on site restaurant and bar, and unwind in a setting designed for both convenience and luxury.", address: "1001 E. McCarty Lane San Marcos, TX", lat: 29.8648, long: -97.9232, imageName: "hotel5")
]

struct Item: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let price: String
    let desc: String
    let address: String
    let lat: Double
    let long: Double
    let imageName: String
}


// MARK: - ContentView

struct ContentView: View {
    let categories = ["All"] + Array(Set(data.map { $0.category })).sorted()
    @State private var selectedCategory = "All"

    var filteredData: [Item] {
        selectedCategory == "All" ? data : data.filter { $0.category == selectedCategory }
    }

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 29.8878, longitude: -97.9405),
        span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
    )

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {

                // Extra top padding so picker breathes below the large nav title
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categories, id: \.self) { category in
                        Text(category).tag(category)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 10)

                // Scrollable cards — capped so map always shows below
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(filteredData) { item in
                            NavigationLink(destination: DetailView(item: item)) {
                                HStack(spacing: 12) {
                    Image(item.imageName)
                    .resizable()
                                        .scaledToFill()
                                        .frame(width: 64, height: 64)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))

                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("✨ \(item.name)")
                                            .font(.system(size: 15, weight: .bold, design: .rounded))
                                            .foregroundColor(.pink)
                                            .lineLimit(1)

                                        HStack(spacing: 4) {
                                            Text(item.category == "Pet Friendly" ? "🐾" : "🎓")
                                                .font(.system(size: 10))
                                            Text(item.category)
                                                .font(.system(size: 11, design: .rounded))
                                                .foregroundColor(.purple)
                                        }
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 3)
                                        .background(pastelPurple.opacity(0.6))
                                        .cornerRadius(20)

                                        Text(item.address)
                                            .font(.system(size: 11, design: .rounded))
                                            .foregroundColor(.orange)
                                            .lineLimit(1)
                                    }

                                    Spacer()

                                    Text(item.price)
                                        .font(.system(size: 13, weight: .bold, design: .rounded))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(
                                            LinearGradient(
                                                colors: [Color.pink.opacity(0.85), Color.purple.opacity(0.85)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .cornerRadius(20)
                                }
                                .padding(11)
                                .background(Color.white.opacity(0.95))
                                .cornerRadius(18)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(pastelPink, lineWidth: 1.5)
                                )
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, 14)
                    .padding(.vertical, 6)
                }
                .frame(maxHeight: 360)

                // Map divider
                HStack {
                    VStack { Divider() }
                    Text("📍 Map")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    VStack { Divider() }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 6)

                // Map — fills remaining space
                Map(coordinateRegion: $region, annotationItems: filteredData) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        VStack(spacing: 2) {
                            ZStack {
                                Circle()
                                    .fill(
                                        LinearGradient(
                                            colors: [Color.pink.opacity(0.9), Color.purple.opacity(0.9)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .frame(width: 32, height: 32)
                                Image(systemName: "building.2.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 14))
                            }
                            Text(item.name)
                                .font(.system(size: 9, weight: .semibold, design: .rounded))
                                .foregroundColor(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .padding(.horizontal, 4)
                                .padding(.vertical, 2)
                                .background(Color.white.opacity(0.85))
                                .cornerRadius(6)
                        }
                    }
                }
                .frame(maxHeight: .infinity)
                .cornerRadius(20)
                .padding(.horizontal, 14)
                .padding(.bottom, 14)

            }
            .background(pastelPink.opacity(0.15))
            .navigationTitle("🏨 Hotels in San Marcos")
        }
    }
}


// MARK: - DetailView (Updated)

struct DetailView: View {
    @State private var region: MKCoordinateRegion

    init(item: Item) {
        self.item = item
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        ))
    }

    let item: Item

    var body: some View {
        ZStack {
            // Dreamy pastel gradient background
            LinearGradient(
                colors: [pastelPink.opacity(0.4), pastelPurple.opacity(0.3), pastelBlue.opacity(0.3)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {

                    ZStack {
                        // Frosted white card behind the image
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white.opacity(0.55))
                            .frame(height: 220)
                            .padding(.horizontal, 16)
                            .shadow(color: pastelPink.opacity(0.3), radius: 20, x: 0, y: 10)

                        // Hero image with soft glow
                        Image(item.imageName)
                               .resizable()
                               .aspectRatio(contentMode: .fit)
                               .shadow(color: pastelPink.opacity(0.4), radius: 30, x: 0, y: 15)
                               .shadow(color: pastelPurple.opacity(0.4), radius: 30, x: 0, y: 15)
                               .blur(radius: 0.3)
                               .clipShape(RoundedRectangle(cornerRadius: 30))
                       }
                       .padding(.horizontal, 16)
               
                    VStack(spacing: 16) {

                        // Hotel name
                        Text(item.name)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.45))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)

                        // Price + category row
                        HStack(spacing: 10) {
                            HStack(spacing: 5) {
                                Image(systemName: "moon.stars.fill")
                                    .font(.system(size: 11))
                                    .foregroundColor(.white)
                                Text(item.price + " / night")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                LinearGradient(
                                    colors: [Color.pink.opacity(0.8), Color(red: 0.7, green: 0.4, blue: 0.9).opacity(0.85)],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(20)

                            HStack(spacing: 5) {
                                Text(item.category == "Pet Friendly" ? "🐾" : "🎓")
                                    .font(.system(size: 12))
                                Text(item.category)
                                    .font(.system(size: 12, design: .rounded))
                                    .foregroundColor(Color(red: 0.45, green: 0.2, blue: 0.65))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(pastelPurple)
                            .cornerRadius(20)
                        }

                        // Address
                        HStack(spacing: 6) {
                            Image(systemName: "mappin.and.ellipse")
                                .foregroundColor(Color.pink.opacity(0.7))
                                .font(.system(size: 13))
                            Text(item.address)
                                .font(.system(size: 13, design: .rounded))
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 20)

                        // Dotted pastel divider
                        HStack(spacing: 0) {
                            ForEach(0..<30) { i in
                                Circle()
                                    .fill(i % 2 == 0 ? pastelPink : pastelPurple)
                                    .frame(width: 4, height: 4)
                                Spacer()
                            }
                        }
                        .padding(.horizontal, 20)

                        // Quick amenity pills
                        HStack(spacing: 8) {
                            InfoPill(icon: "wifi", label: "Wi-Fi", color: pastelBlue)
                            InfoPill(icon: "figure.pool.swim", label: "Pool", color: pastelMint)
                            InfoPill(icon: "cup.and.saucer.fill", label: "Breakfast", color: pastelYellow)
                        }
                        .padding(.horizontal, 16)

                        // About card
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(spacing: 6) {
                                Image(systemName: "sparkles")
                                    .foregroundColor(.pink)
                                    .font(.system(size: 13))
                                Text("About this hotel")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.45))
                            }
                            Text(item.desc)
                                .font(.system(size: 14, design: .rounded))
                                .foregroundColor(Color(red: 0.3, green: 0.25, blue: 0.38))
                                .lineSpacing(5)
                        }
                        .padding(16)
                        .background(Color.white.opacity(0.65))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(pastelPurple, lineWidth: 1.5)
                        )
                        .padding(.horizontal, 16)

                        // Location header
                        HStack(spacing: 6) {
                            Image(systemName: "map.fill")
                                .foregroundColor(.pink)
                                .font(.system(size: 13))
                            Text("Location")
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.6, green: 0.2, blue: 0.45))
                            Spacer()
                        }
                        .padding(.horizontal, 20)

                        // Map
                        Map(coordinateRegion: $region, annotationItems: [item]) { item in
                            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                VStack(spacing: 2) {
                                    ZStack {
                                        Circle()
                                            .fill(
                                                LinearGradient(
                                                    colors: [Color.pink.opacity(0.9), Color.purple.opacity(0.9)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 36, height: 36)
                                        Image(systemName: "building.2.fill")
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                    }
                                    Text(item.name)
                                        .font(.system(size: 10, weight: .semibold, design: .rounded))
                                        .foregroundColor(.black)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .padding(.horizontal, 5)
                                        .padding(.vertical, 2)
                                        .background(Color.white.opacity(0.9))
                                        .cornerRadius(6)
                                }
                            }
                        }
                        .frame(height: 220)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(pastelPurple, lineWidth: 1.5)
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 34)

                    } // end inner VStack
                    .padding(.top, 12)

                } // end outer VStack
            } // end ScrollView
        } // end ZStack
    }
}

// MARK: - InfoPill

struct InfoPill: View {
    let icon: String
    let label: String
    let color: Color

    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .font(.system(size: 11))
                .foregroundColor(Color(red: 0.45, green: 0.2, blue: 0.55))
            Text(label)
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundColor(Color(red: 0.45, green: 0.2, blue: 0.55))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(color.opacity(0.8))
        .cornerRadius(14)
    }
}


#Preview {
    ContentView()
}
