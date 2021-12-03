# frozen_string_literal: true

class Diagnostics
  def initialize
    @gamma_rate = 0
    @epsilon_rate = 0
  end

  def get_gamma_rate(power_consumption_data)
    gamma_rate_in_binary = String.new
    counter = 0

    while counter < power_consumption_data[0].length
      zero_bits = get_number_of_zero_bits(power_consumption_data,counter)
      one_bits = get_number_of_one_bits(power_consumption_data,counter)

      if zero_bits > one_bits
        gamma_rate_in_binary += "0"
      else
        gamma_rate_in_binary += "1"
      end

      counter += 1
    end  

    return gamma_rate_in_binary.to_i(2)
  end

  def get_epsilon_rate(power_consumption_data)
    epsilon_rate_in_binary = String.new
    counter = 0

    while counter < power_consumption_data[0].length
      zero_bits = get_number_of_zero_bits(power_consumption_data,counter)
      one_bits = get_number_of_one_bits(power_consumption_data,counter)

      if one_bits > zero_bits
        epsilon_rate_in_binary += "0"
      else
        epsilon_rate_in_binary += "1"
      end

      counter += 1
    end  

    return epsilon_rate_in_binary.to_i(2)
  end

  def get_power_consumption(power_consumption_data)
    return get_gamma_rate(power_consumption_data) * get_epsilon_rate(power_consumption_data)
  end

  def get_number_of_zero_bits(data,char)
    zero_bits = 0

    data.each do | pcd |
        zero_bits += 1 if pcd.chars[char] == "0"
    end

    return zero_bits
  end  

  def get_number_of_one_bits(data,char)
    one_bits = 0

    data.each do | pcd |
        one_bits += 1 if pcd.chars[char] == "1"
    end

    return one_bits
  end  
end

data = File.read("#{File.dirname(__FILE__)}/input.txt").split
puts Diagnostics.new.get_power_consumption(data)


