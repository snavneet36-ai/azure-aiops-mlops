
import os
import joblib
import pandas as pd

DATA_PATH = "data/metrics.csv"
MODEL_PATH = "models/anomaly_model.joblib"
OUTPUT_PATH = "data/anomaly_results.csv"

FEATURES = [
    "cpu_usage",
    "memory_usage",
    "response_time_ms",
    "error_rate",
]


def detect_anomalies():
    if not os.path.exists(DATA_PATH):
        raise FileNotFoundError(f"Metrics file not found: {DATA_PATH}")

    if not os.path.exists(MODEL_PATH):
        raise FileNotFoundError(f"Trained model not found: {MODEL_PATH}")

    data = pd.read_csv(DATA_PATH)
    model = joblib.load(MODEL_PATH)

    predictions = model.predict(data[FEATURES])

    data["anomaly_prediction"] = predictions
    data["anomaly_status"] = data["anomaly_prediction"].map({
        1: "Normal",
        -1: "Anomaly",
    })

    os.makedirs("data", exist_ok=True)
    data.to_csv(OUTPUT_PATH, index=False)

    anomaly_count = int((predictions == -1).sum())

    print("Anomaly detection completed successfully.")
    print(f"Total records: {len(data)}")
    print(f"Normal records: {len(data) - anomaly_count}")
    print(f"Anomaly records: {anomaly_count}")
    print(f"Results saved to: {OUTPUT_PATH}")
    print("\nSample results:")
    print(data.head(10))


if __name__ == "__main__":
    detect_anomalies()
