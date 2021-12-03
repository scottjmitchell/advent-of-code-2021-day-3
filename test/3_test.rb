# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/3'

class DiagnosticsTest < Minitest::Test
  def setup
    @diagnostics = Diagnostics.new
    @test_data = [
      "00100",
      "11110",
      "10110",
      "10111",
      "10101",
      "01111",
      "00111",
      "11100",
      "10000",
      "11001",
      "00010",
      "01010"
    ]
  end

  def test_gamma_rate_pulls_correctly
    assert @diagnostics.get_gamma_rate(@test_data) == 22
  end

  def test_epsilon_rate_pulls_correctly
    assert @diagnostics.get_epsilon_rate(@test_data) == 9
  end


end
