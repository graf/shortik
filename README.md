## Simple URL Shortener

1. Short URL and store it forever
2. Counts requests for each shorten URL

### How to Run
```bash
docker-compose build
docker-compose run rails bundle
docker-compose run rails rails db:prepare
docker-compose up
```

#### How to Use

1\. Short URL
```bash
curl -d "http://www.example.com" -X POST http://localhost:3000/url
```

2\. Show original URL for short URL
```bash
curl http://localhost:3000/urls/asdfg
```

3\. Show Short URL statistic
```bash
curl http://localhost:3000/urls/asdfg/stats
```

