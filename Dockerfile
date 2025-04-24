# ---- Stage 1: Scraper (Node.js + Puppeteer) ----
FROM node:22-slim as scraper

    # Install Chromium and fonts
    RUN apt-get update && apt-get install -y \
      chromium \
      fonts-liberation \
      libappindicator3-1 \
      libasound2 \
      libatk-bridge2.0-0 \
      libatk1.0-0 \
      libcups2 \
      libdbus-1-3 \
      libgbm1 \
      libnspr4 \
      libnss3 \
      libx11-xcb1 \
      libxcomposite1 \
      libxdamage1 \
      libxrandr2 \
      xdg-utils \
      --no-install-recommends && \
      rm -rf /var/lib/apt/lists/*
    
    # Set Puppeteer to use installed Chromium
    ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
    
    WORKDIR /app
    COPY package.json .
    RUN npm install
    COPY scrape.js .
    
    # Set the URL to scrape at build time via --build-arg
    ARG SCRAPE_URL
    ENV SCRAPE_URL=${SCRAPE_URL}
    
    # Run the scraping script
    RUN node scrape.js
    
    # ---- Stage 2: Server (Python + Flask) ----
FROM python:3.11-slim as server
    
    WORKDIR /app
    
    # Install Flask
    COPY requirements.txt .
    RUN pip install --no-cache-dir -r requirements.txt
    
    # Copy server script and scraped data
    COPY server.py .
    COPY --from=scraper /app/scraped_data.json .
    
    # Expose port and start Flask
    EXPOSE 5000
    CMD ["python", "server.py"]
    