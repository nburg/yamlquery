class YamlQuery::Output
  def flatten_results
    # TODO
  end

  def self.display_results(file, results, options)
    puts file
    if options[:onlyfile?]
    elsif options[:depth]
      gather_keys(results, options[:depth])
    elsif options[:yaml?]
      puts Psych.dump(results)
      puts
    elsif options[:oneline?]
      p results
      puts
    else
      pp results
      puts
    end
  end

  def self.gather_keys(results, depth, index = 1)
    if index == depth.to_i
      puts results.keys
    else
      results.each do |k, v|
        gather_keys(v, depth, index + 1) if v.is_a?(Hash)
      end
    end
  end
end
