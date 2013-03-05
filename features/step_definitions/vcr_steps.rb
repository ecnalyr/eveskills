require 'vcr'

Before do |scenario|
  if scenario.respond_to? :scenario_outline
    feature = scenario.scenario_outline.feature
  else
    feature = scenario.feature
  end

  cassette_name = "#{feature.name.split("\n").first}/#{scenario.name}"
  VCR.insert_cassette(cassette_name)
end

After do
  VCR.eject_cassette
end