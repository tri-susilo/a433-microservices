FROM node:18-alpine

# Menentukan direktori kerja dalam container

WORKDIR /app

# Menyalin file package.json dan package-lock.json ke direktori kerja

COPY package*.json ./

# Menginstall dependensi aplikasi menggunakan npm

RUN npm ci

# Menyalin semua file aplikasi ke dalam direktori kerja

COPY . .

# Membuka port 3000 pada container untuk akses aplikasi

EXPOSE 3000

# Menentukan perintah yang dijalankan saat container berjalan

CMD ["npm", "run", "start"]