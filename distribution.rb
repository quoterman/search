require 'nokogiri'
require 'unicode'
require_relative 'plotter'

class String
  def downcase
    Unicode::downcase(self)
  end

  def sanitize
    self.split.collect do |token|
      token.downcase.gsub(/[^-A-Za-zА-Яа-я0-9]/, '')
    end
  end
end

module Zipf
  class Distribution
    include Zipf::Plotter

    B = 1.15 #1.15 for IOG, AK and O
    P = 10 ** 5.2 #10**5.2 for IOG, 10**5.21 for AK, 10**5.15 for O
    Ro = 25 #25 for IOG, 15 for AK, 20 for O

    def initialize(filename)
      @filename = filename
    end

    def text
      @text ||= Nokogiri::HTML(File.open(@filename)).css('dd').text.sanitize
    end

    def frequency
      @freq ||= begin
        freq = Hash.new(0)
        text.each do |word|
        if !(word.include? '--') and (word != '')
          freq[word] ||= 0
          freq[word] += 1
        end
        end
        Hash[freq.sort_by { |k, v| -v}]
      end
    end

    def ranks
      @ranks ||= begin
        ranks = {}
        rank = 1
        frequency.each do |k, v|
          ranks[k] = rank
          rank += 1
        end
        ranks
      end
    end

    def probability(word)
      frequency[word].to_f / frequency.keys.length
    end

    def zipf_const()
      @zipf ||= begin
        zipf = {}
        tmp = []
        frequency.each do |k, v|
          tmp << v * ranks[k]
        end
        const = tmp.inject{ |sum, el| sum + el }.to_f / tmp.size
        frequency.each do |k, v|
          zipf[k] = Math::log(const / ranks[k].to_f)
        end
        zipf
      end
    end
  end
end