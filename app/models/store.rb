class Store
  def self.teams_by_code
    YAML.safe_load(File.read(Rails.root.join("config", "teams.yaml")))
  end

  def self.players_by_code(year)
    players_by_year = YAML.safe_load(File.read(Rails.root.join("config", "players.yaml")))

    players_by_year[year] || []
  end
end
