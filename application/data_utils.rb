# frozen_string_literal: true

module DataUtils
  SEED = 'database/database.yaml'

  def load
    YAML.load_file(SEED)
  end

  def save(summary)
    row = TableRow.new(summary)
    return File.write(SEED, [row].to_yaml) unless File.exist?(SEED)

    table = load
    table << row
    File.write(SEED, table.to_yaml)
  end
end
