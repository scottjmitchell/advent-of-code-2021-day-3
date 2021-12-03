# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/3'

class DiagnosticsTest < Minitest::Test
  def setup
    @diagnostics = Diagnostics.new
    @test_data = [
      '00100',
      '11110',
      '10110',
      '10111',
      '10101',
      '01111',
      '00111',
      '11100',
      '10000',
      '11001',
      '00010',
      '01010'
    ]
  end

  def test_gamma_rate_is_correct
    assert @diagnostics.get_gamma_rate(@test_data) == 22
  end

  def test_epsilon_rate_is_correct
    assert @diagnostics.get_epsilon_rate(@test_data) == 9
  end

  def test_power_consumption_is_correct
    assert @diagnostics.get_power_consumption(@test_data) == 198
  end

  def test_oxygen_generator_rating_is_correct
    assert @diagnostics.get_oxygen_generator_rating(@test_data) == 23
  end

  def test_co2_scrubber_rating_is_correct
    assert @diagnostics.get_co2_scrubber_rating(@test_data) == 10
  end

  def test_life_support_rating_is_correct
    assert @diagnostics.get_life_support_rating(@test_data) == 230
  end 
end
