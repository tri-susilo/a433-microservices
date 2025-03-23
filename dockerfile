# Menggunakan base image Node.js versi 14
FROM node:14                         

# Menentukan working directory untuk container
WORKDIR /app 

# Menyalin seluruh source code ke working directory container
COPY . .

# Menginstal dependencies untuk production dan kemudian build aplikasi
RUN npm install --production --unsafe-perm && npm run build

# Menentukan agar aplikasi berjalan dalam production mode dan menggunakan container bernama item-db sebagai database host
ENV NODE_ENV=production DB_HOST=item-db

# Mengekspos port 8080 agar container dapat diakses
EXPOSE 8080

# Menjalankan server saat container diluncurkan
CMD ["npm", "start"]
