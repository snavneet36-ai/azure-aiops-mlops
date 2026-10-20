import os
import joblib
import pandas as pd

from sklearn.ensemble import IsolationForest
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline


DATA_PATH = "data/metrics.csv"
MODEL_PATH = "models/anomaly_model.joblib"

FEATURES = [
    "cpu_usage",
    "memory_usage",
    "response_time_ms",
    "error_rate",
]


def train_model():
    if not os.path.exists(DATA_PATH):
        raise FileNotFoundError(
            f"Metrics file not found: {DATA_PATH}. "
            "Run generate_metrics.py first."
        )

    data = pd.read_csv(DATA_PATH)
    X = data[FEATURES]

    model = Pipeline([
        ("scaler", StandardScaler()),
        (
            "detector",
            IsolationForest(
                n_estimators=100,
                contamination=0.05,
                random_state=42,
            ),
        ),
    ])

    model.fit(X)

    os.makedirs("models", exist_ok=True)
    joblib.dump(model, MODEL_PATH)

    predictions = model.predict(X)
    anomaly_count = int((predictions == -1).sum())

    print("Model training completed successfully.")
    print(f"Total records: {len(X)}")
    print(f"Detected anomalies: {anomaly_count}")
    print(f"Model saved to: {MODEL_PATH}")


if __name__ == "__main__":
    train_model()