# frozen_string_literal: true

module DataUtils
  DATABASE = 'database/database.yaml'

  def load
    YAML.load_file(DATABASE)
  end

  def save(summary)
    row = TableRow.new(summary)
    return File.write(DATABASE, [row].to_yaml) unless File.exist?(DATABASE)

    table = load
    table << row
    File.write(DATABASE, table.to_yaml)
  end
end
