
import os
import pandas as pd

INPUT_PATH = "data/anomaly_results.csv"
OUTPUT_PATH = "data/alerts.csv"


def determine_severity(row):
    if (
        row["cpu_usage"] >= 95
        or row["memory_usage"] >= 95
        or row["response_time_ms"] >= 2000
        or row["error_rate"] >= 20
    ):
        return "Critical"

    if (
        row["cpu_usage"] >= 85
        or row["memory_usage"] >= 85
        or row["response_time_ms"] >= 1000
        or row["error_rate"] >= 5
    ):
        return "High"

    return "Medium"


def generate_alerts():
    if not os.path.exists(INPUT_PATH):
        raise FileNotFoundError(
            f"Results file not found: {INPUT_PATH}. "
            "Run detect_anomalies.py first."
        )

    data = pd.read_csv(INPUT_PATH)

    anomalies = data[data["anomaly_prediction"] == -1].copy()

    if anomalies.empty:
        print("No anomalies detected. No alerts generated.")
        return

    anomalies["severity"] = anomalies.apply(determine_severity, axis=1)

    anomalies["alert_message"] = anomalies.apply(
        lambda row: (
            f'{row["severity"]} alert: '
            f'CPU={row["cpu_usage"]:.1f}%, '
            f'Memory={row["memory_usage"]:.1f}%, '
            f'ResponseTime={row["response_time_ms"]:.1f}ms, '
            f'ErrorRate={row["error_rate"]:.1f}%'
        ),
        axis=1,
    )

    anomalies.to_csv(OUTPUT_PATH, index=False)

    print("Alert generation completed.")
    print(f"Total anomalies: {len(anomalies)}")
    print("\nAlerts by severity:")
    print(anomalies["severity"].value_counts().to_string())
    print(f"\nAlerts saved to: {OUTPUT_PATH}")
    print("\nSample alerts:")
    print(anomalies[["severity", "alert_message"]].head(5).to_string(index=False))


if __name__ == "__main__":
    generate_alerts()
