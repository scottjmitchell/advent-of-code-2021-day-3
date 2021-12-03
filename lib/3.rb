# frozen_string_literal: true

class Diagnostics
  def get_gamma_rate(power_consumption_data)
    gamma_rate_in_binary = String.new
    counter = 0

    while counter < power_consumption_data[0].length
      zero_bits = get_number_of_zero_bits(power_consumption_data, counter)
      one_bits = get_number_of_one_bits(power_consumption_data, counter)

      gamma_rate_in_binary += if zero_bits > one_bits
                                '0'
                              else
                                '1'
                              end

      counter += 1
    end

    gamma_rate_in_binary.to_i(2)
  end

  def get_epsilon_rate(power_consumption_data)
    epsilon_rate_in_binary = String.new
    counter = 0

    while counter < power_consumption_data[0].length
      zero_bits = get_number_of_zero_bits(power_consumption_data, counter)
      one_bits = get_number_of_one_bits(power_consumption_data, counter)

      epsilon_rate_in_binary += if one_bits > zero_bits
                                  '0'
                                else
                                  '1'
                                end

      counter += 1
    end

    epsilon_rate_in_binary.to_i(2)
  end

  def get_power_consumption(power_consumption_data)
    get_gamma_rate(power_consumption_data) * get_epsilon_rate(power_consumption_data)
  end

  def get_oxygen_generator_rating(power_consumption_data)
    char = 0
    data = power_consumption_data

    while data.length > 1
      zero_bits = get_number_of_zero_bits(data, char)
      one_bits = get_number_of_one_bits(data, char)

      data = if one_bits >= zero_bits
               data.select { |n| n.chars[char] == '1' }
             else
               data.select { |n| n.chars[char] == '0' }
             end
      char += 1
    end
    data[0].to_i(2)
  end

  def get_co2_scrubber_rating(power_consumption_data)
    char = 0
    data = power_consumption_data

    while data.length > 1
      zero_bits = get_number_of_zero_bits(data, char)
      one_bits = get_number_of_one_bits(data, char)

      data = if zero_bits > one_bits
               data.select { |n| n.chars[char] == '1' }
             else
               data.select { |n| n.chars[char] == '0' }
             end
      char += 1
    end
    data[0].to_i(2)
  end

  def get_life_support_rating(power_consumption_data)
    get_oxygen_generator_rating(power_consumption_data) * get_co2_scrubber_rating(power_consumption_data)
  end

  def get_number_of_zero_bits(data, char)
    zero_bits = 0

    data.each do |d|
      zero_bits += 1 if d.chars[char] == '0'
    end

    zero_bits
  end

  def get_number_of_one_bits(data, char)
    one_bits = 0

    data.each do |d|
      one_bits += 1 if d.chars[char] == '1'
    end

    one_bits
  end
end

data = File.read("#{File.dirname(__FILE__)}/input.txt").split
d = Diagnostics.new

puts d.get_power_consumption(data)
puts d.get_life_support_rating(data)


