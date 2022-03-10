# Parsing Product dan pagination
nokogiri = Nokogiri.HTML(content)
raise "Walmart Verification detected" unless nokogiri.css('div#sign-in-widget').size == 0
listing_page = page['vars']['listing_page'] #buat mengetahui halaman listing
item_rank = 1 # posisi item di halaman listing

products = nokogiri.css('a.absolute.w-100.h-100.z-1') # Container yang memuat link product
raise "Item in page is not 40" if products.size != 40 #Akomodir kasus dimana ga ketangkap 40 produk dalam 1 page
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
            "upgrade-insecure-requests" => "1"
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
                });",
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
            "upgrade-insecure-requests" => "1"
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
                });",
            "disable_adblocker": false,
            "stealth": true
        }
    }
end