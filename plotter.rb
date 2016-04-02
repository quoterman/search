require 'gruff'
module Zipf
  module Plotter
    def plot_ranks_frequency(output)
      labels = []
      data = []
      zipf = []

      frequency.each_with_index do |(k, v), i|
        labels << Math::log(i+1)
        data << Math::log(v)
        zipf << zipf_const[k]
      end

      plot(data, zipf, labels, 'Charts', output)
    end

    private
    def plot(data, zipf, labels, title, output)
      graph = Gruff::Line.new

      #p labels

      graph.title = title
      graph.theme = Gruff::Themes::GREYSCALE
      graph.dataxy('Text', labels, data, '#f61100')
      graph.dataxy('Zipf constant', labels, zipf, '#FDD84E')
      graph.labels = {1 => '1', 5 => '5', 10 => '10'}

      graph.write(output)
    end
  end
end