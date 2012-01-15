RSpec::Matchers.define :match_position do |expected|
  match do |actual|
    actual.to_s.strip.tr(' ', '') == expected.strip.tr(' ', '')
  end
end