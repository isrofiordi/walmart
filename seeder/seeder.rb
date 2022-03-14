cookie = "vtc=c7HhJGJw8mGwYDL4vXkw50; bstc=c7HhJGJw8mGwYDL4vXkw50; xpm=1%2B1647284688%2Bc7HhJGJw8mGwYDL4vXkw50~%2B0; ak_bmsc=D774BF0E3AB075771A502372DC1F7DA7~000000000000000000000000000000~YAAQpBFDJBCHQGt/AQAAU67RiQ/Lp5I3CBBeR7JruTOojzveg+/Qv7ORb3Oi5NZzKmyIVOkehDz30We+saFVrc7UFIw3oUPIZPJC4DgBCH1rJNW3Uto+hPUMskCylumoD/HYXFqzk+C/AQL9UnddndDcw/4lBolHgUCCg1ht096753cHzV+xKyKCgytEt3UOoNm1QsKZ75VweRZgQAXzgnSGLJDRIP8qjkrgR17qIfjnLfbqzTb4tBNEVkAtGv0+9Ej68PemO2qCaOqzHbPIWFPM1J8VyOQliR6ZkC4U0Z/cfQUEx82KGYk3HaDzPCwCM50osQwa5q5NZ…mMetricSessionID=7df5dfb45eb355c690002743dd9438e2; QuantumMetricUserID=50b0904d87e78dd5e9f49c33061d09c8; TS01b0be75=01538efd7c2faefddcfadc29c96d78813a4c249bf6230518973e8085887eaf50960805f64a67fec25597afbcaf13828e361bb5ea84; akavpau_p2=1647285445~id=d16f76afbeabf345388c62c56fe550c4; xptwg=2986909363:566D32E54D3C68:E1570D:A7922D9:7B06B032:C1D01FDE:; TS013ed49a=01538efd7c2faefddcfadc29c96d78813a4c249bf6230518973e8085887eaf50960805f64a67fec25597afbcaf13828e361bb5ea84; pxcts=015bade2-a3ca-11ec-9f96-765656726765"

pages << {
  page_type: "listings",
  method: "GET",
  headers: {
      "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
      "sec-ch-ua" => '"Not A;Brand";v="99", "Chromium";v="98", "Google Chrome";v="98"',
      "sec-ch-ua-mobile"=> "?0",
      "sec-ch-ua-platform"=> '"Linux"',
      "sec-fetch-dest"=> "document",
      "sec-fetch-mode"=> "navigate",
      "sec-fetch-site" => "same-origin",
      "sec-fetch-user" => "?1",
      "upgrade-insecure-requests" => "1",
      'Cookie' => cookie
    },
  display: {
        "width": 1366,
        "height": 768
        },
  driver: {
          code: "
            await page.setViewport({
              width: 1920 + Math.floor(Math.random() * 100),
              height: 3000 + Math.floor(Math.random() * 100),
              deviceScaleFactor: 1,
              hasTouch: false,
              isLandscape: false,
              isMobile: false
            });
            ",
          "disable_adblocker": false,
          "enable_images": false,
          "stealth": true
  },
  # screenshot: {
  #         "take_screenshot": true,
  #         "options": {
  #           "fullPage": true,
  #           "type": "jpeg",
  #           "quality": 75
  #           }
  #         },
  url: "https://www.walmart.com/browse/movies-tv-shows/4096?facet=new_releases:Last+90+Days",
  fetch_type: "browser",
  vars: {"listing_page" => 1}
}