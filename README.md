# NS-2 Congestion Control Simulation

## Overview
This project simulates network congestion in a wireless ad-hoc network using NS-2. The simulation records key network performance metrics such as packet loss, throughput, delay, and jitter. A Bash script automates multiple runs of the simulation with different parameters and collects the results in a CSV file for further analysis.

Currently, this project is in its early stages. The primary focus has been on **data collection**, and further work is needed to develop and implement congestion control mechanisms based on the gathered data.

## Files
- **congestion.tcl** - The main NS-2 TCL script for simulating network congestion.
- **run_simulation.sh** - Bash script to run multiple NS-2 simulations with randomized parameters and collect data.
- **metrics.awk** - AWK script to parse the NS-2 trace file and extract network performance metrics.
- **network_metrics.csv** - Output file containing collected simulation results in CSV format.

## Requirements
- **NS-2 (Network Simulator 2)**
- **AWK (for processing trace files)**
- **Bash (for automation script)**

## How to Run
### 1. Run a Single Simulation
To run a single NS-2 simulation, use:
```sh
ns congestion.tcl <num_nodes> <x_dim> <y_dim> <packet_size> <rate>
```
Example:
```sh
ns congestion.tcl 20 500 500 1024 5Mb
```

### 2. Run Multiple Simulations and Collect Data
Use the Bash script to run 50 randomized simulations and store results in `network_metrics.csv`:
```sh
chmod +x run_simulation.sh
./run_simulation.sh
```

### 3. Analyze Metrics
The `network_metrics.csv` file will contain:
```
Nodes,Packets Sent,Packets Received,Packet Loss,Packet Delivery Ratio,Avg Delay,Throughput,Avg Jitter
...
```

## Output Metrics Explained
- **Packets Sent**: Total packets transmitted.
- **Packets Received**: Successfully received packets.
- **Packet Loss**: Difference between sent and received packets.
- **Packet Delivery Ratio**: Percentage of received packets over sent packets.
- **Avg Delay**: Average time taken for packet transmission.
- **Throughput**: Overall data rate achieved in the simulation.
- **Avg Jitter**: Variation in packet delay.

## Visualization
To visualize the network simulation, open the `.nam` file generated after the simulation:
```sh
nam congestion.nam
```

## Future Work
- Implement congestion control mechanisms based on collected data.
- Explore machine learning models to predict and mitigate congestion.
- Optimize network performance by tuning protocol parameters.

## License
This project is open-source and can be used for research and academic purposes.

