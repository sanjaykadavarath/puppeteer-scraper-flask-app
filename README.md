# puppeteer-scraper-flask-app-docker
A multi-stage Dockerized project using Node.js with Puppeteer for headless web scraping and Python Flask to serve the scraped content via a lightweight API.

# DevOps Assignment – Puppeteer Scraper + Flask API

This project demonstrates a multi-stage Docker setup:

- Uses **Node.js + Puppeteer** to scrape the `<title>` and first `<h1>` from a given webpage.
- Uses **Python + Flask** to serve the scraped data as a JSON API.
- Keeps the final Docker image lean by excluding unnecessary build tools.

---

## 📦 Folder Structure
. 
├── Dockerfile 
├── scrape.js 
├── server.py 
├── package.json 
├── requirements.txt 
└── README.md


---RUNNING

## 🚀 How to Build and Run

### 1. Build the Docker Image

```bash
docker build --build-arg SCRAPE_URL="https://news.ycombinator.com" -t scraper-flask-app .
