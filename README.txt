# ⚡ EV Charging Operations Intelligence

An interactive Power BI dashboard designed to simulate an EV charging session while providing operational analytics for charging performance, energy consumption, revenue and failures.

## 🎯 Project Objective

Traditional dashboards mainly display charts.

This project was designed differently — combining a **realistic EV charging experience** with **business intelligence**.

The goal is to understand:

- How charging sessions perform
- How much energy is consumed
- How long charging takes
- Charging revenue
- Failed and cancelled sessions
- Vehicle and connector performance
- Station operational status

## 🔄 Interactive Charging Flow

The dashboard follows a simulated charging journey:

**Select Vehicle → Connector Selection → Continue Charging → Charging State → 100% Battery → Charging Completed → Go Ahead**

Vehicle selection dynamically changes the corresponding connector and dashboard analysis.

## 📊 Key Analytics

- Total Charging Sessions
- Total Energy Consumed
- Average Charging Time
- Total Charging Revenue
- Charging Status
- Vehicle Type Analysis
- Connector Type Analysis
- Charging Duration Analysis
- Failure Analysis
- Station Status

## 🛠️ Tech Stack

- **Excel** — Dataset preparation
- **SQL** — Data exploration and aggregation
- **Power BI** — Dashboard development
- **DAX** — KPI calculations
- **Power BI Bookmarks** — Interactive charging states
- **Selection Pane** — Dynamic image/state control

## 💡 Business Value

The dashboard can help charging operators understand:

- Charging demand and usage
- Operational performance
- Failure patterns
- Connector performance
- Energy consumption
- Revenue generation
- Overall charging-session efficiency

## 🚀 Project Highlights

### Interactive Vehicle Selection
Users can select:

- Crossover
- Sedan
- SUV
- Hatchback

The charging connector changes according to the selected vehicle.

### Charging Simulation
The dashboard visually represents:

**Available → Charging → Completed → Ready**

with additional operational states for:

**Failed → Cancelled → Maintenance → Offline**

### KPI Monitoring

The dashboard provides a single-screen operational view of:

**Sessions | Energy | Charging Time | Revenue | Status**

## 📁 Project Files

```text
EV-Charging-Operations-Intelligence/
│
├── EV_Charging_Operations_Intelligence.xlsx
├── EV_Charging_Operations_Intelligence.sql
├── EV_Charging_Operations_Intelligence.pbix
├── README.md
└── screenshots/