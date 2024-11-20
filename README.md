# 🎬 Proyek ETL: Integrasi dan Analisis Data Film

## 👥 **Anggota Tim**
- **Melvin Waluyo** (22/492978/TK/53972)
- **Alexander Johan Pramudito** (22/492990/TK/53976)
- **Muhammad Grandiv Lava Putra** (22/493242/TK/54023)

---

## 🎥 Link
- **[Video Presentasi](https://drive.google.com/drive/folders/17eQVF93vAJVQnhyyTYDUw2mQQXbxwUuA?usp=sharing)**  
- **[Dokumentasi Notion](https://grandiv.notion.site/ETL-Kelompok-Melodi-144c13751b738034ace1ea442b0136c3?pvs=74)**  

---

## 📖 **Deskripsi Proyek**
Proyek ini membangun pipeline ETL (Extract, Transform, Load) yang mengintegrasikan data dari berbagai sumber, mengubahnya menjadi format yang bersih dan terstruktur, lalu memuatnya ke dalam database PostgreSQL. Tujuan utamanya adalah menyediakan data film yang akurat dan relevan untuk analisis mendalam yang dapat mendukung pengambilan keputusan di industri hiburan.

---

## 🧐 **Latar Belakang Masalah**
### ⚙️ **Tantangan yang Diatasi**
1. **Sumber Data yang Beragam**: Menyatukan format data dari IMDb, API, dan hasil web scraping.
2. **Ketidakkonsistenan Data**: Membersihkan dan menghilangkan data duplikat dari berbagai platform.
3. **Kebutuhan Integrasi Kompleks**: Menggabungkan peringkat film, ketersediaan streaming, dan harga.
4. **Manajemen Basis Data**: Penyimpanan dan pengelolaan data yang efisien untuk analisis.
5. **Kerumitan Alur Kerja ETL**: Membangun pipeline otomatis yang skalabel.

---

## 🎯 **Tujuan**
1. **Mengintegrasikan Data**: Menggabungkan data film dari IMDb, Google Search, OMDb API, Utelly API, dan uNoGS API.
2. **Membersihkan dan Menyusun Data**: Memastikan data akurat dengan transformasi yang terdefinisi dengan baik.
3. **Mendukung Analisis**: Menyediakan basis data untuk eksplorasi seperti:
   - Peringkat IMDb berdasarkan platform streaming.
   - Genre populer per platform.
   - Dampak sutradara dan aktor terhadap performa film.
4. **Otomatisasi Alur Kerja**: Menggunakan Apache Airflow untuk menjadwalkan dan mengelola proses ETL.
5. **Optimasi Manajemen Data**: Memuat data terstruktur ke PostgreSQL untuk aksesibilitas dan skalabilitas.

---

## 📊 **Sumber Data**
1. **IMDb**: Web scraping untuk daftar 250 film terbaik berdasarkan rating.
2. **Google Search**: Hasil scraping ketersediaan layanan streaming dan harga untuk setiap film.
3. **OMDb API**: Informasi film seperti aktor, sutradara, dan genre.
4. **Utelly API**: Ketersediaan film di platform streaming tertentu.
5. **uNoGS API**: Katalog Netflix dengan rating IMDb >= 7 di AS.

---

## 🛠️ **Arsitektur Alur Kerja**

1. **Extract**: Mengumpulkan data mentah dari web scraping dan API.
2. **Transform**: Membersihkan, menggabungkan, dan memfilter data menggunakan `pandas`.
3. **Load**: Menyimpan data yang telah diolah ke PostgreSQL menggunakan `pgAdmin`.

---

## 💻 **Teknologi yang Digunakan**
- **Bahasa Pemrograman**: Python
- **Manajemen Data**: PostgreSQL
- **Orkestrasi**: Apache Airflow
- **Mesin Virtual**: Azure (Standard B2s) dengan 2 vCPUs dan RAM 4 GiB

---

## 🗂️ **Skema Basis Data**
Database terdiri dari 9 tabel terstruktur:
1. `movie`: Informasi utama tentang film.
2. `movie_actor`: Hubungan antara film dan aktor.
3. `movie_director`: Hubungan antara film dan sutradara.
4. `google_movie_streaming`: Ketersediaan dan harga streaming dari Google.
5. `google_streaming_service`: Detail layanan streaming Google.
6. `utelly_movie_streaming`: Ketersediaan streaming dari Utelly.
7. `utelly_streaming_service`: Detail layanan streaming Utelly.
8. `netflix_movie`: Data katalog Netflix.
9. `top_imdb`: Film dengan rating tertinggi di IMDb.

---

## 🔄 **Otomatisasi dengan Apache Airflow**
Pipeline ETL diotomatisasi menggunakan Apache Airflow:
- **Nama DAG**: `ETL_Melodi`
- **Jadwal**: Berjalan setiap tanggal 1 bulan pukul 00:00.
- **Tugas**:
  1. Mengekstrak data IMDb.
  2. Mengekstrak data dari OMDb dan Utelly API.
  3. Mengekstrak data dari uNoGS API.
  4. Transformasi data menggunakan Jupyter notebook.
  5. Menyiapkan tabel PostgreSQL.
  6. Memuat data ke PostgreSQL.

---
# 📄 Instalasi Apache Airflow di Linux Ubuntu

Panduan ini menjelaskan langkah-langkah untuk menginstal Apache Airflow di Linux Ubuntu menggunakan virtual environment Python dari Anaconda.

---

## 🛠️ Langkah-Langkah Instalasi

### 1. **Persiapan Lingkungan**
1. **Install Ubuntu 22.04** di Azure Virtual Machine / AWS EC2 :
2. Instalasi desktop environment xfce4 untuk Ubuntu di [Azure.](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/use-remote-desktop?tabs=azure-cli)

2. **Install Anaconda**:
   - Kunjungi [Anaconda.com](https://www.anaconda.com/products/individual) dan download file Debian Anaconda.
   - Jalankan instalasi menggunakan terminal:
     ```bash
     bash Anaconda3-2024.10-1-Linux-x86_64.sh
     ```

3. **Buat Environment**:
   - Buat folder dan environment di Anaconda:
     ```bash
     mkdir airflow-environment
     cd airflow-environment
     conda create --name airflow-environment python=3.9
     conda activate airflow-environment
     ```

4. **Set AIRFLOW_HOME**:
   - Tentukan lokasi folder kerja Airflow dengan perintah:
     ```bash
     export AIRFLOW_HOME=/home/username/Documents/airflow-environment
     ```

   > **Catatan:** Lakukan langkah ini setiap kali membuka terminal baru.

---

### 2. **Instalasi Dependensi**
1. **Install Dependensi Dasar**:
   - Install dependensi yang diperlukan oleh Airflow dan sistem menggunakan `apt-get`:
     ```bash
     sudo apt-get update && sudo apt-get install -y python3-pip python-dev libffi-dev libssl-dev zip wget
     sudo apt-get install gcc python3-dev
     ```

2. **Install Apache Airflow**:
   - Install Airflow dan tambahan modul yang diperlukan:
     ```bash
     pip install apache-airflow
     pip install apache-airflow[kubernetes]
     pip install statsd pyspark cryptography
     ```

---

### 3. **Inisialisasi dan Konfigurasi Airflow**
1. **Inisialisasi Database Airflow**:
   - Jalankan perintah berikut untuk inisialisasi database Airflow:
     ```bash
     airflow db init
     ```

2. **Buat User Admin** (Hanya dilakukan sekali saat pertama kali):
   - Untuk membuat user admin untuk akses UI Airflow:
     ```bash
     airflow users create --role Admin --username admin --email admin@example.com \
     --firstname Admin --lastname User --password your_password
     ```

---

### 4. **Menjalankan Airflow**
1. **Menjalankan Webserver**:
   - Jalankan webserver Airflow pada port 8080:
     ```bash
     airflow webserver -p 8080
     ```

2. **Menjalankan Scheduler**:
   - Jalankan scheduler Airflow di terminal terpisah:
     ```bash
     airflow scheduler
     ```

3. **Memasukkan File DAG**:
    - Buat folder ke dalam environment yang sudah dibuat
        ```bash
        mkdir /home/username/Documents/airflow-environment/dags
        ```
    - Masukkan file DAG ke dalam folder tersebut
    - Jalankan file DAG
        ```bash
        python3 namaDAG.py
        ```
    


---

### 5. **Akses Web UI**
- Buka browser dan akses: **[http://localhost:8080](http://localhost:8080)**  
- Login menggunakan username dan password admin yang telah dibuat.

---

## 🛑 Cara Menghentikan Airflow
1. **Menghentikan Webserver dan Scheduler**:
   - Tekan `Ctrl + C` di terminal yang menjalankan webserver atau scheduler.
   - Atau gunakan perintah untuk menemukan dan menghentikan proses yang sedang berjalan:
     ```bash
     lsof -i tcp:8080
     kill <pid>
     ```

---

## 📌 Catatan Tambahan
- Setiap kali membuka terminal baru, aktifkan environment dan set ulang `AIRFLOW_HOME`:
  ```bash
  conda activate airflow-environment
  export AIRFLOW_HOME=/path/to/airflow-environment

---

## 🏁 **Kesimpulan**
Pipeline ETL yang dibangun berhasil memanfaatkan:
- **Apache Airflow**: Untuk menjadwalkan dan mengelola otomatisasi proses ETL.
- **Pandas**: Untuk melakukan transformasi data sebelum dimuat ke **Azure PostgreSQL Server**.

Dengan hasil basis data yang jelas dan terstruktur, pipeline ini mendukung berbagai analisis penting dalam industri hiburan, seperti:
1. **Peringkat IMDb Berdasarkan Platform Streaming**: Memberikan wawasan tentang performa film di berbagai layanan streaming.
2. **Distribusi Genre Film pada Setiap Layanan**: Membantu memahami preferensi genre pada platform tertentu.
3. **Pengaruh Aktor atau Sutradara terhadap Performa Film**: Menganalisis kontribusi individu terhadap kesuksesan film.

Pipeline ini tidak hanya menyediakan data yang bersih tetapi juga memastikan fleksibilitas bagi data scientist untuk memperluas analisis mereka sesuai kebutuhan industri. Hasil ini mendukung keputusan strategis berbasis data di sektor hiburan. 🎥📊
