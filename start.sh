#!/bin/bash

sudo apt update -y
sudo apt install cron -y
sudo apt install toilet -y
sudo apt install sox -y


# التحقق من الأدوات المطلوبة
command -v toilet >/dev/null 2>&1 || { echo "يرجى تثبيت 'toilet' لاستخدام المؤثرات النصية!"; exit 1; }
command -v play >/dev/null 2>&1 || { echo "يرجى تثبيت 'sox' لتفعيل الأصوات!"; exit 1; }

# دالة الرسوم المتحركة المحسنة
animate() {
    echo -ne "\e[32m"
    local chars="/-\|*"
    for i in {1..40}; do
        printf "["
        for j in $(seq 1 $i); do printf "#"; done
        for k in $(seq $i 39); do printf " "; done
        printf "] %3d%% %s\r" $((i*5/2)) "${chars:RANDOM%4:1}"
        sleep 0.1
    done
    echo -e "\e[0m"
}

# توليد بيانات وهمية
generate_fake_data() {
    echo -e "\033[35m"
    echo "┌───────────────────────────────┐"
    echo "│    \033[36m بيانات النظام المخترق \033[35m    │"
    echo "├───────────────────────────────┤"
    echo "│ الإصدار: v$(shuf -i 1-9 -n 1).$(shuf -i 0-9 -n 1).$(shuf -i 0-9 -n 1) │"
    echo "│ نظام التشغيل: $(shuf -e "iOS 16" "Android 14" "Windows 12" -n 1) │"
    echo "│ الموقع: $(shuf -e "نيويورك" "لندن" "طوكيو" "برلين" -n 1)       │"
    echo "└───────────────────────────────┘"
    echo -e "\033[0m"
}

# محاكاة الاختراق
advanced_hack() {
    clear
    echo -e "\n\033[35m[✦] تهيئة بيئة الاختراق المتقدمة...\033[0m"
    sleep 2
    play -n synth 0.5 sin 1000 2>/dev/null
    
    echo -e "\n\033[36m[✦] تحليل IP الهدف: $target_ip\033[0m"
    echo -n "• تتبع الموقع الجغرافي..."
    sleep 1
    echo -e "\033[32m ✓\033[0m"
    
    echo -e "\n\033[34m[✦] شن الهجوم الأولي..."
    sleep 2
    animate
    echo "• تم اكتشاف ثغرة SQL Injection!"
    
    echo -e "\n\033[31m[✦] اختراق جدار الحماية..."
    sleep 2
    echo -n "• تجاوز الفحص الأمني..."
    sleep 2
    echo -e "\033[32m ✓\033[0m"
    
    echo -e "\n\033[33m[✦] تهيئة أدوات القرصنة..."
    sleep 2
    echo "• تحميل Metasploit"
    echo "• تفعيل Nmap"
    echo "• تحليل نقاط الضعف"
    animate
    
    echo -e "\n\033[35m[✦] فك التشفير..."
    sleep 3
    echo -n "• تحليل البيانات المشفرة..."
    sleep 2
    echo -e "\033[32m ✓\033[0m"
    
    generate_fake_data
    
    echo -e "\n\033[36m[✦] استخراج بيانات الحساب..."
    sleep 3
    echo "• تحميل الملفات الحساسة"
    echo "• استخراج 500 صورة خاصة"
    echo "• 2,500 رسالة دردشة"
    animate
    
    echo -e "\n\033[31m[✦] تثبيت باب خلفي..."
    sleep 2
    echo "• تفعيل Keylogger"
    echo "• تسجيل كل ضغطات لوحة المفاتيح"
    echo "• مراقبة الجهاز في الوقت الحقيقي"
    animate
    
    echo -e "\n\033[5m\033[31m[!] تمت السيطرة الكاملة على الهدف!\033[0m"
    sleep 1
    play -n synth 0.5 sin 800 2>/dev/null
    
    echo -e "\n\033[31m"
    echo " ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄ "
    echo "▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌"
    echo "▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀█░▌▐░█▀▀▀▀▀▀▀▀▀ "
    echo "▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          "
    echo "▐░▌       ▐░▌▐░█▄▄▄▄▄▄▄█░▌▐░█▄▄▄▄▄▄▄▄▄ "
    echo "▐░▌       ▐░▌▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌"
    echo "▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌"
    echo "▐░▌       ▐░▌▐░▌       ▐░▌          ▐░▌"
    echo "▐░█▄▄▄▄▄▄▄█░▌▐░▌       ▐░▌ ▄▄▄▄▄▄▄▄▄█░▌"
    echo "▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌"
    echo " ▀▀▀▀▀▀▀▀▀▀▀  ▀         ▀  ▀▀▀▀▀▀▀▀▀▀▀ "
    echo -e "\033[0m"
}

# عرض العنوان بتأثيرات مميزة
clear
echo -e "\n\033[36m"
toilet -f future "HACK v6.0" --metal
echo -e "\033[0m"

# إدخال بيانات الهدف
echo -ne "\033[33mأدخل IP الهدف: \033[0m"
read target_ip
echo -ne "\033[33mأدخل رابط الحساب المستهدف: \033[0m"
read account_url
echo -ne "\033[33mأدخل اسم المستخدم المستهدف: \033[0m"
read username

# تشغيل المحاكاة
advanced_hack

# تحذير في النهاية
echo -e "\n\n\033[47m\033[30m[ تحذير: هذه الأداة للأغراض التعليمية فقط ]\033[0m"
echo -e "\033[41m\033[37m[!] أي استخدام غير أخلاقي يعرضك للمساءلة القانونية!\033[0m"