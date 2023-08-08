#!/bin/bash

# Установка пакетов
apt-get update
apt-get install -y cups cups-client libcups2-dev cups-bsd system-config-printer ftp

# Удаление cupsd.conf
rm /etc/cups/cupsd.conf

# Подключение по FTP и скачивание файла
ftp -n 192.168.89.138 21 <<END_SCRIPT
quote USER maifl
quote PASS xpg1xpg1
get cupsd.conf /etc/cups/cupsd.conf
quit
END_SCRIPT

# Проверка успешного скачивания файла
if [ -f "/etc/cups/cupsd.conf" ]; then
    echo "Файл cupsd.conf успешно загружен."
else
    echo "Ошибка при загрузке файла cupsd.conf."
fi

# Перезапуск службы CUPS
sudo systemctl restart cups
