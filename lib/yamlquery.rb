class YamlQuery
  def initialize(object, options)
    @object   = object
    @options = options
    tree = parse(@options)
    yqt = YamlQuery::Transform.new
    parsed_query = yqt.apply(tree)
    if options[:debug]
      pp parsed_query
    end
    @keys     = parsed_query[:keys]
    @operator = parsed_query[:operator].to_s
    @arg      = parsed_query[:arg].to_s
  end

  def object_search(object = @object, index = 0)
    result_hash = {}
    object.each do |k, v|
      if @keys[index] == k or @keys[index] == '*'
        if @keys.length == index + 1
          result_hash[k] = v if compare(v)
        elsif v.is_a?(Hash)
          result_hash[k] = object_search(v, index + 1)
          result_hash.delete(k) if result_hash[k].empty?
        end
        # A key shouldn't show up more than once, so we can return
        # as soon as we find a match if we aren't matching a wildcard.
        return result_hash unless @keys[index] == '*'
      end
    end
    return result_hash
  end

  private

  def parse(options)
    yqp = YamlQuery::Parser.new(options[:delimiter])
    yqp.parse(options[:query])
  rescue Parslet::ParseFailed => failure
    puts failure.cause.ascii_tree
  end

  def compare(value)
    case @operator
    when ''
      return true
    when '=='
      equal?(value)
    when '!='
      notequal?(value)
    when '!'
      nil?(value)
    when '>='
      ge?(value)
    when '<='
      le?(value)
    when '<'
      lt?(value)
    when '>'
      gt?(value)
    end
  end

  def assign
    # not yet implemented
  end

  def ge?(value)
    value >= @arg
  end

  def le?(value)
    value <= @arg
  end

  def lt?(value)
    value < @arg
  end

  def gt?(value)
    value > @arg
  end

  def equal?(value)
    case value
    when Array, Hash
      value.include?(@arg)
    else
      value == @arg
    end
  end

  def notequal?(value)
    value != @arg
  end

  def nil?(value)
    case value
    when Array, Hash
      value.empty?
    else
      value.nil?
    end
  end
end

require 'yamlquery/parser'
require 'yamlquery/settings'
require 'yamlquery/output'
require 'pp'
