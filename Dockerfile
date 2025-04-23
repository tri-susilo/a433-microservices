# Stage 1: Install dependencies
#Menginstall image node versi 18 dengan linux alpine sebagai base image
FROM node:18-alpine
#Menetapkan direktori aktif
WORKDIR /src
#Menyalin/copy file package-lock.json dan package.json ke direktori aktif saat ini (/src)
COPY package*.json ./
#Mengatur environment ke produksi
ENV NODE_ENV=production
#Menginstall dependensi yang tertera di file package.json berdasarkan versi pada package-lock.json
##cocok digunakan pada lingkungan produksi
RUN npm ci
#Menyalin semua file dengan ekstensi .js ke direktori aktif saat ini
COPY ./*.js ./
#Menjalankan file index.js saat container pertama kali dijalankan
CMD ["node", "index.js"]
#Membuka port 3000 pada container
EXPOSE 3000
