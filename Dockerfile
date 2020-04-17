# Install dependencies and run npm run build
# as builder lets everything after this FROM run as the builder phase
FROM node:alpine as builder 

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .

# /app/build has all the content we care about that we want to copy over to the run phase
# this means the previous block is done, we don't need another as object to define it
FROM nginx 
EXPOSE 80

# --from so we can copy the output files from a different stage
COPY --from=builder /app/build /usr/share/nginx/html