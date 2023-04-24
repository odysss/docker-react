FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Just by putting in a second from it understands that 
# the previous phase is complete.
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# The default command of the nginx container is to start the
# nginx itself.