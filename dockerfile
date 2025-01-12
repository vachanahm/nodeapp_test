# Stage 1: Build
FROM node:latest AS build

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if present) to install dependencies
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Run build scripts if necessary (e.g., for React/Next.js or other compiled assets)
# RUN npm run build

# Stage 2: Production
FROM node:alpine AS production

# Set working directory
WORKDIR /usr/src/app

# Copy only necessary files from the build stage
COPY --from=build /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/index.js ./index.js
# Add other necessary files like public/static assets if needed
# COPY --from=build /usr/src/app/build ./build

# Expose the application port
EXPOSE 4000

# Command to run the application
CMD [ "node", "index.js" ]

