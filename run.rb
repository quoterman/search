require_relative 'distribution'
start = Time.now

zipf = Zipf::Distribution.new(ARGV[0])
# p zipf.frequency
#p test.ranks
#p test.zipf_const.values
zipf.plot_ranks_frequency("#{ARGV[0]}_zipf.png")

heap = Heap::Distribution.new(ARGV[0])
heap.plot_ranks_frequency("#{ARGV[0]}_heaps.png")



finish = Time.now
puts finish - start