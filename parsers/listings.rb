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
            "User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36",
            "accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8"
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
            "User-Agent" => "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36",
            "accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8"
        }
    }
end