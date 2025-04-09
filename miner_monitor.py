import os
import time
import requests
import psutil
import socket

BOT_TOKEN = "7477012680:AAHGTZbm39L7JL_rc5ypBufFSyG3kQV-Q_0"
CHAT_ID = "5792222595"
LOG_FILE = os.path.expanduser("~/.xmrig/miner.log")

def get_mining_status():
    if not os.path.exists(LOG_FILE):
        return "⚠️ لا يوجد ملف log!"

    try:
        with open(LOG_FILE, "r") as log_file:
            lines = log_file.readlines()[-20:]  

        status = {
            "jobs": 0,
            "errors": 0,
            "last_job_time": "N/A",
            "hash_rate": "N/A"
        }

        for line in lines:
            if "new job" in line:
                status["jobs"] += 1
                try:
                    status["last_job_time"] = line.split("[")[1].split("]")[0]
                except Exception:
                    status["last_job_time"] = "غير متوفر"
            elif "error" in line.lower():
                status["errors"] += 1
            if "H/s" in line:
                try:
                    if "speed:" in line:
                        hr_part = line.split("speed:")[1]
                        hr_value = hr_part.split()[0]
                        status["hash_rate"] = hr_value + " H/s"
                    else:
                        parts = line.split("H/s")[0].split()
                        status["hash_rate"] = parts[-1] + " H/s"
                except Exception:
                    status["hash_rate"] = "N/A"

        return (f"📊 التعدين:\n"
                f"🔹 عدد المهام: {status['jobs']}\n"
                f"❌ أخطاء: {status['errors']}\n"
                f"🕒 آخر تحديث: {status['last_job_time']}\n"
                f"⚡ الهاش: {status['hash_rate']}")
    except Exception as e:
        return f"⚠️ خطأ أثناء تحليل اللوج: {e}"

def get_system_info():
    hostname = socket.gethostname()
    try:
        ip_address = requests.get("https://api64.ipify.org").text
    except Exception:
        ip_address = "غير متوفر"
    cpu_usage = psutil.cpu_percent()
    memory = psutil.virtual_memory()
    memory_usage = memory.percent

    return (f"🖥️ الجهاز: {hostname}\n"
            f"🌍 IP: {ip_address}\n"
            f"⚙️ CPU: {cpu_usage}%\n"
            f"💾 RAM: {memory_usage}%")

def send_telegram_message(message):
    url = f"https://api.telegram.org/bot{BOT_TOKEN}/sendMessage"
    payload = {"chat_id": CHAT_ID, "text": message, "parse_mode": "Markdown"}
    try:
        requests.post(url, data=payload)
    except Exception as e:
        print("Error sending message:", e)

def monitor_mining():
    while True:
        mining_status = get_mining_status()
        system_info = get_system_info()
        message = f"{mining_status}\n\n{system_info}"
        send_telegram_message(message)
        time.sleep(600)  

if __name__ == "__main__":
    pid = os.fork()
    if pid == 0:
        monitor_mining()
