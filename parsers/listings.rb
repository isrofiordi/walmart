# Parsing Product dan pagination
nokogiri = Nokogiri.HTML(content)

products = nokogiri.css('a.absolute.w-100.h-100.z-1') # Container yang memuat link product
products.each do |product|
    href = product['href']
    url = URI.join('https://www.walmart.com', href).to_s
    pages << {
        url: url,
        page_type: 'products',
        fetch_type: 'browser',
        vars: {},
        headers: {
            "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:97.0) Gecko/20100101 Firefox/97.0",
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
            # "Accept-Encoding" => "gzip, deflate, br",
            # "Accept-Language" => "en-US,en;q=0.5",
            # "Host" => "www.walmart.com",
            # "Sec-Fetch-Dest" => "document",
            # "Sec-Fetch-Mode" => "navigate",
            # "Sec-Fetch-Site" => "none",
            # "Sec-Fetch-User" => "?1",
            # "Upgrade-Insecure-Requests" => "1"
            }
    }
end

# Cari page baru, sampai ga bisa klik next

next_page_link = nokogiri.css('a[aria-label="Next Page"]')

if next_page_link[0]
    url = "https://www.walmart.com" + next_page_link[0]["href"]
    pages << {
        url: url,
        page_type: 'listings',
        fetch_type: 'browser',
        vars: {},
        headers: {
            "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:97.0) Gecko/20100101 Firefox/97.0",
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
            # "Accept-Encoding" => "gzip, deflate, br",
            # "Accept-Language" => "en-US,en;q=0.5",
            # "Host" => "www.walmart.com",
            # "Sec-Fetch-Dest" => "document",
            # "Sec-Fetch-Mode" => "navigate",
            # "Sec-Fetch-Site" => "none",
            # "Sec-Fetch-User" => "?1",
            # "Upgrade-Insecure-Requests" => "1"
        }
    }
end