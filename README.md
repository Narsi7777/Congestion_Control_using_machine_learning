# 🚦 NS-2 Congestion Control Simulation with CatBoost Integration

## 🧠 Overview

This project simulates network congestion in a wireless ad-hoc network using **NS-2** and leverages **Machine Learning (CatBoost)** to dynamically predict and mitigate congestion before simulation. 

The project consists of two phases:
1. **Data Collection Phase**: Using traditional NS-2 scripts and automation tools to gather performance metrics under various conditions.
2. **ML-Based Control Phase**: Applying a CatBoost classifier to predict congestion and dynamically adjust simulation parameters to prevent it.

---

## 📂 Project Structure

### 🔧 Traditional NS-2 Simulation & Data Collection
- `congestion.tcl` – NS-2 TCL script to simulate network behavior.
- `run_simulation.sh` – Bash script to run 50 simulations with randomized parameters.
- `metrics.awk` – AWK script to extract performance metrics from NS-2 trace files.
- `network_metrics.csv` – Output file containing collected metrics in CSV format.

### 🧠 ML-Based Congestion Control (CatBoost)
- `train_catboost_model.py` – Trains a CatBoost classifier using labeled data (`output.csv`).
- `simulate_with_catboost.py` – Runs NS-2 simulations, adjusting parameters using ML predictions.
- `catboost_predictor.py` – Core logic for predicting and adjusting based on ML model.
- `output.csv` – Labeled dataset for training, containing features and congestion labels.
- `catboost_congestion_model.pkl` – Trained ML model (auto-generated after training).

---

## ✅ Requirements

- **NS-2 (Network Simulator 2)**
- **AWK** – For processing trace files.
- **Python 3.8+** with:
  - `catboost`
  - `scikit-learn`
  - `pandas`
  - `joblib`

---

## 🚀 How to Run

### 🔹 1. Run a Single Traditional NS-2 Simulation
```bash
ns congestion.tcl <num_nodes> <x_dim> <y_dim> <packet_size> <rate>
