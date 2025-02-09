# Stage 1: Build the React app
FROM node:16 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to leverage caching
COPY package*.json ./

# Install dependencies
RUN npm install --legacy-peer-deps

# Copies all files, including the public directory
COPY . .

# Build the app
RUN npm run build

# Stage 2: Serve the built app with Nginx
FROM nginx:alpine

# Copy the built app from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 5007 for the web server
EXPOSE 5007

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]