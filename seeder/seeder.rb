pages << {
  page_type: "listings",
  method: "GET",
  headers: {
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
        "sec-ch-ua" => "'Not A;Brand';v='99', 'Chromium';v='98', 'Google Chrome';v='98'"
        # "Accept-Language" => "en-US,en;q=0.5",
        # "Host" => "www.walmart.com",
        # "Sec-Fetch-Dest" => "document",
        # "Sec-Fetch-Mode" => "navigate",
        # "Sec-Fetch-Site" => "none",
        # "Sec-Fetch-User" => "?1",
        # "Upgrade-Insecure-Requests" => "1"
    },
  display: {
        "width": 800,
        "height": 600
        },
  screenshot: {
          "take_screenshot": true,
          "options": {
            "fullPage": true,
            "type": "jpeg",
            "quality": 75
            }
          },
  url: "https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases:Last+90+Days",
  fetch_type: "browser"
}