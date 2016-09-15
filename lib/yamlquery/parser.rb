require 'parslet'

class YamlQuery::Parser < Parslet::Parser
  def initialize(delimiter)
    @delimiter = delimiter
  end
  rule(:key) { match("[^\s#{@delimiter}!<>&= ]").repeat(1) >> space? }

  rule(:space) { match('\s').repeat(1) }
  rule(:space?) { space.maybe }

  rule(:delimiter) { match("\\#{@delimiter}") >> space? }
  rule(:delimiter?) { delimiter.maybe >> space? }

  rule(:operator) { match('[&!=><]') >> match('=').maybe >> space? }
  rule(:argument) { match('.').repeat(1) }
  rule(:argument?) { argument.maybe }

  rule(:keypath) { key.as(:key) >> delimiter? }
  rule(:expression) { operator.as(:operator) >> argument?.as(:arg) }
  rule(:expression?) { expression.maybe }
  rule(:rooty) { keypath.repeat(1).as(:keys) >> expression? }
  root(:rooty)
end

class YamlQuery::Transform < Parslet::Transform
  rule(:key => simple(:x)) { String(x) }
end
