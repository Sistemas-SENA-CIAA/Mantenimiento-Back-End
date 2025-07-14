FROM node:18-alpine

WORKDIR /app

# Copiar archivos de configuración
COPY package*.json ./
COPY tsconfig.json ./

# Instalar dependencias (incluyendo TypeScript en producción)
RUN npm install --include=dev

# Copiar código fuente
COPY . .

# Compilar TypeScript
RUN npx tsc

# Limpiar dependencias de desarrollo (opcional)
RUN npm prune --production

# Exponer puerto
EXPOSE 6506

# Comando de inicio
CMD ["node", "build/index.js"]
