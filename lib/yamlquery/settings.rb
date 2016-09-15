require 'optparse'
require 'psych'

class YamlQuery::Settings
  @options = {}

  attr_reader :options

  def self.get_options
    get_rc
    set_default
    get_flags
    @options
  end

  private 

  def self.get_flags
    OptionParser.new do |opts|
      opts.banner = 'Usage: yq [options] "yaml.path.to.parameter"'

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end

      opts.on('-y', '--yaml', "Generate output as yaml") do
        @options[:yaml?] = true
      end

      opts.on('-d', '--depth DEPTH', 'Only return keys from DEPTH in output') do |depth|
        @options[:depth] = depth
      end

      opts.on('-p', '--yamlpath PATH', 'Path to yaml files', String) do |path|
        @options[:yamlpath] = path
      end

      opts.on('-f', '--onlyfile', 'Only list file names that match') do
        @options[:onlyfile?] = true
      end

      opts.on('-1', '--oneline', 'Matches will be displayed in oneline mode') do
        @options[:oneline?] = true
      end

      opts.on('-d', '--debug', 'Matches will be displayed in oneline mode') do
        @options[:debug] = true
      end
    end.parse!

    if ARGV.empty?
      puts 'Query string is required.'
      exit 1
    else
      @options[:query] = ARGV[0]
    end
  end

  def self.get_rc
    yqrc_path = "#{ENV['HOME']}/.yqrc.yaml"
    if File.exist?(yqrc_path)
      @options = Psych.load_file(yqrc_path)
    end
  end

  def self.set_default
    @options[:delimiter] = '.'
  end

end
