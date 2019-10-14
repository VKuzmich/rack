# frozen_string_literal: true

module DataUtils
  SEED = 'database/seed.yaml'

  def load
    YAML.load_file(SEED)
  end

  def save(summary)
    row = TableRow.new(summary)
    File.open(SEED, 'a+') { |f| f.write([row].to_yaml) }
  end
end
