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

module Heap
  module Plotter
    def plot_ranks_frequency(output)
      labels = []
      data = []
      heap = heap_const

      frequency.each_with_index do |v, i| 
        labels << Math::log(i+1)
        data << Math::log(v)
      end

      plot(data, labels, heap, 'Charts', output)
    end

    private
    def plot(data, labels, heap, title, output)
      graph = Gruff::Line.new

      # p labels

      graph.title = title
      graph.theme = Gruff::Themes::GREYSCALE
      graph.dataxy('Text', labels, data, '#f61100')
      graph.dataxy('Heap constant', labels, heap, '#FDD84E')
      graph.minimum_value = 0

      graph.write(output)
    end
  end
end