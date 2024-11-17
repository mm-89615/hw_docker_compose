# Dockerfile

# Базовый образ для Python
FROM python:3.9-slim

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Устанавливаем зависимости системы
RUN apt-get update && apt-get install -y netcat-openbsd

# Копируем файл зависимостей и устанавливаем зависимости Python
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Копируем проект в контейнер
COPY . /app/

# Копируем entrypoint.sh в контейнер
COPY entrypoint.sh /app/

# Делаем entrypoint.sh исполняемым
RUN chmod +x /app/entrypoint.sh

# Открываем порт
EXPOSE 8000

# Указываем entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]
