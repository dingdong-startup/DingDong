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
@intermediate =[]
@Sh=[] #shared flat accepted or not
@Vs = ""
@Ps = ""
@Ss = ""
@Fs = ""
@Rs
@Fu = [] #furnished or not
@Rintermediate = []
@Rintermediatebis = []



def flat_scrapper ()
  # page_image = Nokogiri::HTML(open('https://www.airbnb.fr/s/Paris/homes?refinement_paths%5B%5D=%2Fhomes&adults=0&children=0&infants=0&guests=0&place_id=ChIJD7fiBh9u5kcRYJSMaMOCCwQ&click_referer=t%3ASEE_ALL%7Csid%3A9d3f7bdf-ff75-4c7b-99db-469ef83da30e%7Cst%3AMAGAZINE_HOMES&title_type=MAGAZINE_HOMES&query=Paris&allow_override%5B%5D=&s_tag=v9JpW3bS'))
  # @I= page_image.xpath('//body')
  # puts "Images url"
  # puts @I.to_s
  page = Nokogiri::HTML(open('https://www.flatlooker.com/appartements?utf8=%E2%9C%93&room_count_1=false&room_count_2=false&room_count_3=false&room_count_4=false&room_count_5=false&min_latitude=48.762749606303565&min_longitude=2.200325842396969&max_latitude=48.96150853951048&max_longitude=2.440651770131344&page=1&prix_max=9999&surface_min=30&zoom=12&furnished=&move_search=true'))
  @Vs = page.xpath('//div/a/div/strong').text
  @Ps = page.xpath('//div/a/div/p/strong[1]').text
  @Ss = page.xpath('//div/a/div/p/strong[2]').text.delete("-")
  @Rs = page.xpath('//div/a/div/small').text
  @Fd = page.xpath('//div/a/div/small').text
  @V = @Vs.split(')')
  @S = @Ss.split('m2')
  @P = @Ps.split('€')
  @V.map!{|e| e + ")"}
  @Rintermediate = @Rs.delete("\u0095").split("\n\n")

  @Rintermediate.map!{|e| e.split("\n")}
  # @Rintermediate.map!{|e| e.delete('')}
  # @Rintermediate.map!{|e| e.map{ |a| a.strip!}}
  @Rintermediate.map{|e| e.delete("")}
  @Rintermediate.map{|e| e.map{ |a| a.strip!}}


  @Rintermediate.each{|e| @R << e[0]}
  @Rintermediate.each{|e| @Fu << e[1]}
  # puts @Rs
  puts @Rintermediate.to_s
  puts @R.to_s
  # puts @F.to_s

  page.xpath('//div[1]/a/@href')[6..-1].first(4).each_slice(2) do |url, url_bis|
    complete_url = 'https://www.flatlooker.com' + url
    @U << complete_url

    # puts @address
    page_flat = Nokogiri::HTML(open(complete_url))
    @T << page_flat.xpath('//*[@id="annonce"]/div[1]/div[1]/h3').text
    @F << page_flat.xpath('//*[@id="table-essentials"]/tbody/tr[2]/td[4]').text
    @R << page_flat.xpath('//body/div[6]/div[6]/div/div/div[1]/div[1]').text
    @D << page_flat.xpath('//*[@id="annonce"]/div[2]/div[1]/div').text
    @ad << page_flat.xpath('//body/div[6]/div[6]/div/div/h4').text
    @Sh << page_flat.xpath('//*[@id="table-essentials"]/tbody/tr[1]/td[4]').text
    @Itot << image_hash(complete_url,page_flat)



  end

end

def image_hash(url,page)
  @I.clear
  for i in 1..5
    href = '//*[@id="slick-slide0' + i.to_s + '"]/img/@src'
    @I << page.xpath(href)
    puts "je suis la"
    puts @I.to_s
  end
  return @I
end


# puts @T.to_s, @S.to_s, @P.to_s, @V.to_s, @F.to_s, @R.to_s, @D.to_s, @ad.to_s

#   page.xpath("//*[@id="header-offer-ED20A669-765C-652D-C932-7063775917AF"]/div/div[2]/div[1]/div[1]/div[1]/p[1]/a").first(4).each do |node|
#     @B << node.text
#   end
#   page.xpath("//*[@id="header-offer-ED20A669-765C-652D-C932-7063775917AF"]/div/div[2]/div[1]/div[3]/div/div/div[2]/h3/span[1]").first(4).each do |node|
#     @C << node.text
#   end
def clean(array)
  return array.map!{ |element| element.strip.gsub(/\n/, '')}.map!{ |element| element.gsub(/\r/, '')}
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
  page_test = Nokogiri::HTML(open('https://www.flatlooker.com/appartements/location-meublee-9-m2-cambronne-75015-paris'))
  puts page_test.xpath('//*[@id="slick-container"]/div[6]/div/div/div/img/@src')

  flat_scrapper
  @intermediatebis = @T.zip(@S, @D, @V, @F, @R, @ad, @P, @Fu, @Itot)
  @intermediate = @T.zip(@S, @D, @V, @F, @R, @ad, @P, @Fu)
  @intermediate.each{|array| clean(array)}
  @intermediatebis.each{|x| @A << {"title" => x[0], "superficie" => x[1], "description" => x[2], "ville" => x[3], "floor" => x[4], "room" => x[5], "address" => x[6], "price" => x[7], "furnished" => x[8], "images" => x[9]}}
  puts @A.first.to_s
  puts @A.last.to_s
end

perform
