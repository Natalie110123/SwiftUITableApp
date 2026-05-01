# 🏨 Hotels in San Marcos

A SwiftUI iOS app that helps users discover and explore hotels in San Marcos, Texas. Built with SwiftUI and MapKit, the app features a filterable hotel list, interactive maps, and detailed hotel pages with a pastel aesthetic.

---

## 📱 Features

- **Hotel Listings** — Browse 6 hotels in San Marcos with name, category, address, and nightly price
- **Category Filtering** — Filter hotels by "All," "Near Texas State University," or "Pet Friendly" using a segmented picker
- **Interactive Map** — View all filtered hotel locations on a MapKit map with custom pin annotations
- **Detail View** — Tap any hotel to see a full description, amenity pills, and a focused location map
- **Custom UI** — Pastel pink/purple color theme with rounded cards, gradient price badges, and styled typography

---

## 🗂 Project Structure

```
TableSwiftUI/
├── ContentView.swift       # Main list + map view with category filter
├── Assets.xcassets/        # Hotel images (hotel, hotel2–hotel6)
└── README.md
```

**Key components defined in `ContentView.swift`:**

| Component | Description |
|-----------|-------------|
| `ContentView` | Root view — segmented picker, scrollable hotel cards, overview map |
| `DetailView` | Full hotel detail page — hero image, description, amenity pills, location map |
| `InfoPill` | Reusable pill badge for amenity icons (Wi-Fi, Pool, Breakfast) |
| `Item` | Data model struct with name, category, price, description, address, coordinates, and image name |

---

## 🏗 Requirements

- **Xcode** 15 or later
- **iOS** 16.0+
- **Swift** 5.9+
- Frameworks: `SwiftUI`, `MapKit`

---

## 🚀 Getting Started

1. Clone or download this repository
2. Open `TableSwiftUI.xcodeproj` in Xcode
3. Add hotel images (`hotel`, `hotel2` through `hotel6`) to `Assets.xcassets`
4. Select a simulator or connected device running iOS 16+
5. Press **Run** (`⌘R`)

---

## 📍 Hotel Data

The app includes 6 San Marcos hotels across two categories:

**Near Texas State University**
- Best Western — $119/night
- Fairfield Inn & Suites by Marriott — $129/night
- Comfort Suites — $139/night

**Pet Friendly**
- Holiday Inn — $149/night
- Candlewood Suites — $159/night
- Embassy Suites by Hilton — $189/night

---

## 🎨 Design

The UI uses a custom pastel color palette defined as global `Color` constants:

| Constant | Use |
|----------|-----|
| `pastelPink` | Background tint, card borders |
| `pastelPurple` | Category badges, card overlays |
| `pastelBlue` | Wi-Fi amenity pill |
| `pastelMint` | Pool amenity pill |
| `pastelYellow` | Breakfast amenity pill |
| `pastelGreen` | Accent |

---

## 👩‍💻 Author

Natalie M. Leal — created March 2026 for Texas State University
