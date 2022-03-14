# Parsing Product dan pagination
nokogiri = Nokogiri.HTML(content)
cookie = 'vtc=c7HhJGJw8mGwYDL4vXkw50; bstc=c7HhJGJw8mGwYDL4vXkw50; xpm=1%2B1647284688%2Bc7HhJGJw8mGwYDL4vXkw50~%2B0; ak_bmsc=D774BF0E3AB075771A502372DC1F7DA7~000000000000000000000000000000~YAAQpBFDJBCHQGt/AQAAU67RiQ/Lp5I3CBBeR7JruTOojzveg+/Qv7ORb3Oi5NZzKmyIVOkehDz30We+saFVrc7UFIw3oUPIZPJC4DgBCH1rJNW3Uto+hPUMskCylumoD/HYXFqzk+C/AQL9UnddndDcw/4lBolHgUCCg1ht096753cHzV+xKyKCgytEt3UOoNm1QsKZ75VweRZgQAXzgnSGLJDRIP8qjkrgR17qIfjnLfbqzTb4tBNEVkAtGv0+9Ej68PemO2qCaOqzHbPIWFPM1J8VyOQliR6ZkC4U0Z/cfQUEx82KGYk3HaDzPCwCM50osQwa5q5NZ…mMetricSessionID=7df5dfb45eb355c690002743dd9438e2; QuantumMetricUserID=50b0904d87e78dd5e9f49c33061d09c8; TS01b0be75=01538efd7c2faefddcfadc29c96d78813a4c249bf6230518973e8085887eaf50960805f64a67fec25597afbcaf13828e361bb5ea84; akavpau_p2=1647285445~id=d16f76afbeabf345388c62c56fe550c4; xptwg=2986909363:566D32E54D3C68:E1570D:A7922D9:7B06B032:C1D01FDE:; TS013ed49a=01538efd7c2faefddcfadc29c96d78813a4c249bf6230518973e8085887eaf50960805f64a67fec25597afbcaf13828e361bb5ea84; pxcts=015bade2-a3ca-11ec-9f96-765656726765'

raise "Walmart Verification detected" unless nokogiri.css('div#sign-in-widget').size == 0
listing_page = page['vars']['listing_page'] #buat mengetahui halaman listing
item_rank = 1 # posisi item di halaman listing

products = nokogiri.css('a.absolute.w-100.h-100.z-1') # Container yang memuat link product

if nokogiri.css('a[aria-label="Next Page"]')[0]
    raise "Item in page is not 40" if products.size != 40 #Akomodir kasus dimana ga ketangkap 40 produk dalam 1 page
end

products.each do |product|
    href = product['href']
    url = URI.join('https://www.walmart.com', href).to_s
    pages << {
        url: url,
        page_type: 'products',
        fetch_type: 'browser',
        vars: {
            "listing_page" => listing_page,
            "item_rank" => item_rank
        },
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
                await page.click('div#px-captcha',{delay:12000});
                await sleep(3000);",
            "disable_adblocker": true
        }
    }
    item_rank += 1 # inkremen rank item selanjutnya
end

# Cari page baru, sampai ga bisa klik next

next_page_link = nokogiri.css('a[aria-label="Next Page"]')

if next_page_link[0]
    url = "https://www.walmart.com" + next_page_link[0]["href"]
    pages << {
        url: url,
        page_type: 'listings',
        fetch_type: 'browser',
        vars: {"listing_page" => listing_page+1},
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
                await page.click('div#px-captcha',{delay:12000});
                await sleep(3000);",
            "disable_adblocker": false,
            "stealth": true
        }
    }
end