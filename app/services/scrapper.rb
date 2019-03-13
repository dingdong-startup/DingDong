require 'nokogiri'
require 'open-uri'
require 'byebug'

@U=[] #tableau des href
@A=[] #tableau de hashes
@B=[] #tableau des title
@C=[] #tableau des superficies
@D=[] #tableau des prix
@E=[] #tableau des images
@F=[] #tableau intermédiaire des images d'une maison

def flat_scrapper ()
  page = Nokogiri::HTML(open('https://www.flatlooker.com/appartements?utf8=%E2%9C%93&room_count_1=false&room_count_2=false&room_count_3=false&room_count_4=false&room_count_5=false&min_latitude=48.762749606303565&min_longitude=2.200325842396969&max_latitude=48.96150853951048&max_longitude=2.440651770131344&page=1&prix_max=9999&surface_min=30&zoom=12&furnished=&move_search=true'))
  page.xpath('//div[1]/a/@href').each_slice(2) do |url, url_bis|
    complete_url = 'https://www.flatlooker.com' + url
    @U << complete_url
    page_flat = Nokogiri::HTML(open(complete_url))
    @B << page_flat.xpath('//*[@id="annonce"]/div[1]/div[1]/h3').text
    @C << page_flat.xpath('/html/body/div[4]/div[5]/div/div/div[1]/div[2]').text
    @
  end
  byebug
end
#   page.xpath("//*[@id="header-offer-ED20A669-765C-652D-C932-7063775917AF"]/div/div[2]/div[1]/div[1]/div[1]/p[1]/a").first(4).each do |node|
#     @B << node.text
#   end
#   page.xpath("//*[@id="header-offer-ED20A669-765C-652D-C932-7063775917AF"]/div/div[2]/div[1]/div[3]/div/div/div[2]/h3/span[1]").first(4).each do |node|
#     @C << node.text
#   end


#
# # scrapping sur les pages des annonces
# def get_flat_description_images ()
#   page = Nokogiri::HTML(open("https://www.seloger.com/list.htm?tri=initial&idtypebien=2,1&pxMax=2000&idtt=1&naturebien=1,2,4&ci=750118"))
#   page.xpath("//div[2]/div[2]/span[2]").first(4).each do |node|
#     description = get_flat_description(node["href"])
#     images = get_flat_images(node["href"])
#     @D << description
#     @E << images
#   end
# end
#
# def get_flat_description(url)
#   page = Nokogiri::HTML(open(url))
#   page.xpath('//[@id="js-descriptifBien"]').first(4).each do |node|
#     return node.text
#   end
# end
#
# def get_flat_images(url)
#   @F.clear
#   page = Nokogiri::HTML(open(url))
#   page.xpath('//*[@id="fullScreenSlider"]/div/div/div[3]/img"]').each do |node|
#     @F << node["src"]
#   end
#   page.xpath('//*[@id="slider1"]/div/div/div/div').each do |node|
#     @F << node["data-lazy"].fetch("url")
#   end
#   return F
# end
#


def perform ()
  flat_scrapper
  get_flat_description_images
  @B.zip(@C,@D,@E).each{|x| @A << {"title" => x[0], "superficie" => x[1], "description" => x[2], "images" => x[3] }}
  puts @A.to_s
end

perform
