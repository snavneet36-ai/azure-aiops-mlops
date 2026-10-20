import numpy as np
import pandas as pd


def generate_metrics(rows: int = 1000) -> pd.DataFrame:
    np.random.seed(42)

    # Normal application behavior
    cpu = np.random.normal(45, 10, rows).clip(1, 100)
    memory = np.random.normal(60, 8, rows).clip(1, 100)
    response_time = np.random.normal(250, 60, rows).clip(20, 2000)
    error_rate = np.random.normal(1, 0.5, rows).clip(0, 100)

    data = pd.DataFrame({
        "cpu_usage": cpu,
        "memory_usage": memory,
        "response_time_ms": response_time,
        "error_rate": error_rate,
    })

    # Inject some abnormal application behavior
    anomaly_count = max(1, rows // 20)
    anomaly_indices = np.random.choice(
        rows, size=anomaly_count, replace=False
    )

    data.loc[anomaly_indices, "cpu_usage"] = np.random.uniform(
        90, 100, anomaly_count
    )
    data.loc[anomaly_indices, "response_time_ms"] = np.random.uniform(
        1500, 3000, anomaly_count
    )
    data.loc[anomaly_indices, "error_rate"] = np.random.uniform(
        10, 30, anomaly_count
    )

    return data


if __name__ == "__main__":
    metrics = generate_metrics()

    output_path = "data/metrics.csv"
    import os
    os.makedirs("data", exist_ok=True)

    metrics.to_csv(output_path, index=False)

    print(f"Generated {len(metrics)} metric records.")
    print(f"Saved metrics to {output_path}")
    print(metrics.head())