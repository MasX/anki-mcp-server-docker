FROM python:3.11-slim

RUN apt-get update     \
    && apt-get install -y curl \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN pip install mcpo uv

RUN npm install
RUN npm run build

EXPOSE 8000

CMD ["uvx", "mcpo", "--host", "0.0.0.0", "--port", "8000", "--", "/app/build/index.js"]