# Yamlquery

Searches yaml files for keys and values using a simple query language. This was developed with the intention of managing puppet hiera files.

## Examples

```bash
# yq -y -p ../examples/example.yaml 'foo.funk==head'
---
foo:
  funk:
  - head
  - shoulders
```

## Installation

    $ gem install yamlquery

## Usage

TODO: Write usage instructions here


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nburgess/yamlquery.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

