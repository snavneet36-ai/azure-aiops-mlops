
import pandas as pd

from src.generate_metrics import generate_metrics
from src.alerting import determine_severity


def test_generate_metrics():
    data = generate_metrics(100)

    assert len(data) == 100
    assert "cpu_usage" in data.columns
    assert "memory_usage" in data.columns
    assert "response_time_ms" in data.columns
    assert "error_rate" in data.columns


def test_critical_alert():
    row = pd.Series({
        "cpu_usage": 96,
        "memory_usage": 60,
        "response_time_ms": 200,
        "error_rate": 1,
    })

    assert determine_severity(row) == "Critical"


def test_high_alert():
    row = pd.Series({
        "cpu_usage": 87,
        "memory_usage": 60,
        "response_time_ms": 300,
        "error_rate": 1,
    })

    assert determine_severity(row) == "High"


def test_medium_alert():
    row = pd.Series({
        "cpu_usage": 50,
        "memory_usage": 60,
        "response_time_ms": 250,
        "error_rate": 1,
    })

    assert determine_severity(row) == "Medium"
