FROM node:18-alpine

WORKDIR /app

# Instalar herramientas necesarias
RUN apk add --no-cache python3 make g++

# Copiar archivos de configuración
COPY package*.json ./
COPY tsconfig.json ./

# Limpiar cache de npm e instalar dependencias
RUN npm cache clean --force
RUN npm install --verbose

# Copiar código fuente
COPY . .

# Compilar TypeScript con más información de debug
RUN npx tsc --version
RUN npm run build

# Crear usuario no-root para seguridad
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# Cambiar permisos
RUN chown -R nextjs:nodejs /app
USER nextjs

# Exponer puerto
EXPOSE 3000

# Comando de inicio
CMD ["npm", "start"]
