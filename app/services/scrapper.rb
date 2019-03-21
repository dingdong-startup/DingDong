class Scrapper

require 'nokogiri'
require 'open-uri'
require 'byebug'

def flat_scrapper ()
  #Tableaux utiles pour le scrapping
  @U=Array.new #tableau des href
  @A=Array.new #tableau de hashes
  @T=Array.new #tableau des title
  @S=Array.new #tableau des superficies
  @P=Array.new #tableau des prix
  @F=Array.new #tableau des floors
  @D=Array.new #tableau des descriptions
  @R=Array.new #tableau des rooms
  @Vn=Array.new #tableau des villes
  @Itot=Array.new #tableau des images
  @I=Array.new #tableau intermédiaire des images d'une maison
  @ad=Array.new #tableau des adresses
  @Sh=Array.new #shared flat accepted or not
  @zipcode = [] #tableau des zipcodes
  #tableaux intermédiaires pour la construction du tabkeau final
  @intermediate =Array.new
  @Vni =Array.new
  @Vs = ""
  @Ps = ""
  @Ss = ""
  @Fs = ""
  @Rs
  @Fu =Array.new #furnished or not
  @Rintermediate=Array.new
  @Rintermediatebis=Array.new

  page = Nokogiri::HTML(open('https://www.flatlooker.com/appartements?utf8=%E2%9C%93&reference=&lieu=Paris+18e+Arrondissement%2C+Paris%2C+%C3%8Ele-de-France%2C+France&min_latitude=48.87949421614796&min_longitude=2.3250823240766088&max_latitude=48.904902555676735&max_longitude=2.363727495800305&zoom=14&move_search=true&surface_min=&prix_max='))
# scrapping des datas sur la page d'accueil
  @Vs = page.xpath('//div/a/div/strong').text
  @Ps = page.xpath('//div/a/div/p/strong[1]').text.delete('.0')
  @Ss = page.xpath('//div/a/div/p/strong[2]').text.delete("-").delete('.0')
  @Rs = page.xpath('//div/a/div/small').text
  @ad = page.xpath('//div/a/div/strong').text.split(')')
  # formatage des données à la BDD
  @Vni = @Vs.split(')')
  @S = @Ss.split('m2')
  @P = @Ps.split('€')
  @Vni.map!{|e| e + ")"}
  @ad.map!{|e| e + ")"}
  @Rintermediate = @Rs.delete("\u0095").split("\n\n")
  @Rintermediate.map!{|e| e.split("\n")}
  @Rintermediate.map{|e| e.delete("")}
  @Rintermediate.map{|e| e.map{|a| a.strip!}}
  @Rintermediate.each{|e| @R.push(e[0][0])}
  @Rintermediate.each{|e| @Fu << e[1]}
  @Vni.each{|x| @zipcode << x[-6...-1]}
  @Vni.each{|x| @Vn << x[0...-9]}


# scrapping des données sur le show d'une property
  page.xpath('//div[1]/a/@href')[6..-1].first(14).each_slice(2) do |url, url_bis|
    complete_url = 'https://www.flatlooker.com' + url
    @U << complete_url
    page_flat = Nokogiri::HTML(open(complete_url))
    @T << page_flat.xpath('//*[@id="annonce"]/div[1]/div[1]/h3').text
    @F << page_flat.xpath('//*[@id="table-essentials"]/tbody/tr[2]/td[4]').text[1]
    @R << page_flat.xpath('//body/div[6]/div[6]/div/div/div[1]/div[1]').text
    @D << page_flat.xpath('//*[@id="annonce"]/div[2]/div[1]/div').text
    @Sh << page_flat.xpath('//*[@id="table-essentials"]/tbody/tr[1]/td[4]').text

    for i in (1...21)
      for j in (1...6)
        @I << j.to_s + "flat" + i.to_s

      end
    end
  end

  for i in 0..19
    @Itot << [@I[5*i+0],@I[5*i+1],@I[5*i+2],@I[5*i+3],@I[5*i+4]]
  end

end


def clean(array)
  return array.map!{|element| element.strip.gsub(/\n/, '')}.map!{ |element| element.gsub(/\r/, '')}.map!{ |element| element.gsub(/Flatlooker/, 'Ding Dong')}
end


def perform ()
  flat_scrapper
  clean(@T)
  clean(@S)
  clean(@D)
  clean(@Vn)
  clean(@F)
  clean(@R)
  clean(@ad)
  clean(@P)
  clean(@Fu)
  @intermediate = @T.zip(@S, @D, @Vn, @F, @R, @ad, @P, @Fu, @Itot, @zipcode)
  @intermediate.each{|x| @A << {"title" => x[0], "surface" => x[1], "description" => x[2], "area_name" => x[3], "floor" => x[4], "room" => x[5], "address" => x[6], "price" => x[7], "furnished" => x[8], "images" => x[9], "zipcode" => x[10]}}
  return @A
end

end
