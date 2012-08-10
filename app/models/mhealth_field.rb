class MhealthField
  attr_accessor :source, :name, :type

  def self.get_all(client)
    json = JSON.parse client.get('/v2/health/data').body
    json.map do |measure|
      new measure
    end 
  end

  def initialize(measure_hash)
    self.source = measure_hash['source']
    self.name = measure_hash['name']
    self.type = measure_hash['type']
  end

  def unit
    case self.type
    when 'distance'
      'meter'
    when 'energy'
      'calorie'
    when 'mass'
      'kilogram'
    when 'temperature'
      'fahrenheit'
    when 'duration'
      'second'
    when 'pressure'
      'psi'
    when 'frequency'
      'hertz'
    else
      'example_unit'
    end
  end

  def value
    return rand(36**10).to_s(36) if self.type == 'string'

    return rand(1_000_000).to_f / 1000
  end
end
