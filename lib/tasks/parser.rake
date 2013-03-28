namespace :parser do
	require 'open-uri'
	require 'nokogiri'
	task :get_properties do |p|
		puts 'start'
		doc = open('http://www.benjaminsrealty.com/kw-real-estate').read
		doc = Nokogiri::HTML(doc)
		d = []
		doc.xpath("//ul[@class = 'property-search-right']/li").each do |node|
		  street_number = node.xpath('.//h3').text.strip.split[0]
		  city = node.xpath(".//h3/span").text.strip
		  address = node.xpath('.//h3').text.gsub(city,'').gsub(street_number,'').strip
		  street_suffix = (['AVE', 'ST', 'RD', 'DR', 'CR', 'CRS', 'BVD'].include?(address.split[-1].upcase) ? address.split[-1] : '')		  
		  street_name = address[0...(street_suffix.empty? ? address.length : -street_suffix.length)].strip
		  list_price = node.xpath(".//p[@class = 'price']").text.strip.gsub('$','').gsub(',','').to_f

		  d += [{:city => city, :street_number => street_number, :street_name => street_name, :street_suffix => street_suffix, :list_price => list_price}]
		end
		File.open(Rails.root.join("properties.yml"), "w") do |file|  
		  file.write(YAML.dump d)
		end
		puts 'finish'
	end
	task :seed_properties => :environment do
		props = YAML.load(File.open(Rails.root.join("properties.yml"),"r"))
		props.each do |p|
			admin = User.where(:role == 'ADMIN').first
			pr = Property.new(p)
			pr.owner = admin
			pr.save!		
		end		
	end


#<ul class="property-search-right">

			#if node.text.include?("window.data\['properties'\] = ")		  	
		  #	str = node.text["window.data\['properties'\] = ".length...node.text.index("window.data\['properties_page_info'\]")].tr(';','')		  	
			#	puts str
			#	@parsed_j = ActiveSupport::JSON.decode(str)
			#	puts @parsed_j
		  #end 

end
