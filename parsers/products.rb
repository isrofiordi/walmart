nokogiri = Nokogiri.HTML(content)

# initialize an empty hash
product = {}

#extract title
product['title'] = ""
product['title'] = nokogiri.at_css('h1[itemprop="name"]').text.strip unless nokogiri.at_css('h1[itemprop="name"]').nil?

#extract current price
product['current_price'] = 0.0
product['current_price'] = nokogiri.at_css('span[itemprop="price"]').text.gsub("$","").to_f unless nokogiri.at_css('span[itemprop="price"]').nil?

#extract original price
product['original_price'] = 0.0
product['original_price'] = nokogiri.at_css('span.strike[aria-hidden="true"]').text.gsub("$","").to_f unless nokogiri.at_css('span.strike[aria-hidden="true"]').nil?

#extract rating
product['rating'] = 0.0
product['rating'] = nokogiri.at_css('span.rating-number').text.gsub(/[)(]/,"").to_f unless nokogiri.at_css('span.rating-number').nil?

#extract number of reviews
product['rating'] = "No Review"
product['rating'] = nokogiri.at_css('a[itemprop="ratingCount"]').text unless nokogiri.at_css('a[itemprop="ratingCount"]').nil?

#extract publisher
product['publisher'] = "indie"
product['publisher'] = nokogiri.at_css('div[itemprop="brand"]').text unless nokogiri.at_css('div[itemprop="brand"]').nil?

#extract walmart item number
product['walmart_number'] = 404
product['walmart_number'] = nokogiri.at_css('link[rel="canonical"]')["href"].split('/').last.strip.to_i unless nokogiri.at_css('link[rel="canonical"]').nil?

#early warning system, jika ketemu verifikasi walmart
raise "Element failed to be extracted" if product['walmart_number'] == 404

#extract product image
product['img_url'] = "no_img_url"
product['img_url'] = nokogiri.at_css('div.relative img.db')["src"] unless nokogiri.at_css('div.relative img.db').nil?

#extract product categories
product['categories'] = ""
category_node = nokogiri.css('div.h-100.relative nav.ma3.mh0-m.mh0-xl.mb4-xl ol li')

if category_node
    category_node.each do |cat|
        product['categories'] = product['categories'] + cat
    end
end

# information in product listing page
product["listing_page"] = page['vars']['listing_page']

# information in product rank in listing page
product["item_rank"] = page['vars']['item_rank']

# specify the collection where this record will be stored
product['_collection'] = 'products'

# save the product to the job’s outputs
outputs << product