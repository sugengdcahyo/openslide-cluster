# Gunakan base image Python yang mendukung OpenSlide (misal: debian/bullseye-slim untuk kemudahan)
FROM python:3.10-slim

# Install lib OpenSlide dependencies
RUN apt-get update && \
    apt-get install -y openslide-tools libopenslide0 && \
        rm -rf /var/lib/apt/lists/*

# Buat direktori kerja
WORKDIR /app

# Salin file requirements dan install dependencies python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Salin seluruh project (pastikan Dockerfile di root folder project)
COPY . .

# (Opsional) Expose port Flask, default 5000
EXPOSE 5000

# Jalankan aplikasi Flask (asumsi server.py sudah ada block if __name__ == '__main__')
CMD ["python", "server.py", "--listen", "0.0.0.0", "--port", "5010", "-d", "./media"]

