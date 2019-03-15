require 'nokogiri'
require 'open-uri'
require 'byebug'

@U=[] #tableau des href
@A=[] #tableau de hashes
@T=[] #tableau des title
@S=[] #tableau des superficies
@P=[] #tableau des prix
@F=[] #tableau des floors
@D=[] #tableau des descriptions
@R=[] #tableau des rooms
@V=[] #tableau des villes
@Itot=[] #tableau des images
@I=[] #tableau intermédiaire des images d'une maison
@ad=[] #tableau des adresses

def flat_scrapper ()
  page = Nokogiri::HTML(open('https://www.flatlooker.com/appartements?utf8=%E2%9C%93&room_count_1=false&room_count_2=false&room_count_3=false&room_count_4=false&room_count_5=false&min_latitude=48.762749606303565&min_longitude=2.200325842396969&max_latitude=48.96150853951048&max_longitude=2.440651770131344&page=1&prix_max=9999&surface_min=30&zoom=12&furnished=&move_search=true'))
  page.xpath('//div[1]/a/@href')[6..-1].first(20).each_slice(2) do |url, url_bis|
    complete_url = 'https://www.flatlooker.com' + url
    @U << complete_url
    @V << page.xpath('//*[@id="container_flat_1852"]/div/a/div/strong').text
    @P << page.xpath('//*[@id="container_flat_1852"]/div/a/div/p/strong[1]').text
    @S << page.xpath('//*[@id="container_flat_1852"]/div/a/div/p/strong[2]').text
    puts @address
    page_flat = Nokogiri::HTML(open(complete_url))
    @T << page_flat.xpath('//*[@id="annonce"]/div[1]/div[1]/h3').text
    # byebug
    # @S << page_flat.xpath('/html/body/div[4]/div[5]/div/div/div[1]/div[2]').text
    # @P << page_flat.xpath('/html/body/div[6]/div[6]/div/div/p[2]/strong').text
    # @V << page_flat.xpath('/html/body/div[6]/div[6]/div/div/div[1]/div[2]').text
    @F << page_flat.xpath('//*[@id="table-essentials"]/tbody/tr[2]/td[4]').text
    @R << page_flat.xpath('/html/body/div[6]/div[6]/div/div/div[1]/div[1]').text
    @D << page_flat.xpath('//*[@id="annonce"]/div[2]/div[1]/div').text
    @ad << page_flat.xpath('/html/body/div[6]/div[6]/div/div/h4').text
  end
  # puts @T.to_s, @S.to_s, @P.to_s, @V.to_s, @F.to_s, @R.to_s, @D.to_s, @ad.to_s
  clean(@U)
  clean(@A)
  clean(@T)
  clean(@S)
  clean(@P)
  clean(@F)
  clean(@D)
  clean(@R)
  clean(@V)
  clean(@ad)
end
#   page.xpath("//*[@id="header-offer-ED20A669-765C-652D-C932-7063775917AF"]/div/div[2]/div[1]/div[1]/div[1]/p[1]/a").first(4).each do |node|
#     @B << node.text
#   end
#   page.xpath("//*[@id="header-offer-ED20A669-765C-652D-C932-7063775917AF"]/div/div[2]/div[1]/div[3]/div/div/div[2]/h3/span[1]").first(4).each do |node|
#     @C << node.text
#   end
def clean(array)
 return array.map!{ |element| element.gsub(/\n/, '')}
 # .map!{ |element| element.gsub(/n/, '').gsub(/\n/, '') }
end



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
  @T.zip(@S, @D, @V, @F, @R, @ad).each{|x| @A << {"title" => x[0], "superficie" => x[1], "description" => x[2], "ville" => x[3], "floor" => x[4], "room" => x[5], "address" => x[6] }}
  puts @A.to_s
end

perform
