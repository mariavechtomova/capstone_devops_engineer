FROM nginx:1.19.5

## Step 1:
# Remove default index.html
RUN rm /usr/share/nginx/html/index.html

## Step 2:
# Copy custom index.html to nginx folder
COPY index.html /usr/share/nginx/html