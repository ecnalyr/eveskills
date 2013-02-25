class HomeController < ApplicationController

  require 'open-uri'
  require 'nokogiri'
  
  def index
    @users = User.all

    @api_results = Nokogiri.XML(open("https://api.eveonline.com/char/CharacterSheet.xml.aspx?keyID=1867200&vCode=oReWk9nG5QutSKn03RINpBXajnDtU2egla3uTr4dLQDV4kVTeQodWgy1He7ECeU4").read)
  end
end
