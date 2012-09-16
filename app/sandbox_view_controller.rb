class SandboxViewController < UIViewController
  def viewDidLoad
    super

    begin
      tag = BattleTag.new('Espo', '1977')
      Diablo3::Career.fetch(tag) do |career|
        career.heroes.first.fetch_detail do |detail|
          puts detail.name
          detail.items.keys.each do |key|
            puts key
            detail.items[key].fetch_detail do |item|
              puts item.name
              puts item.image_url
            end
          end
        end
      end
    rescue => e
      Alert(e)
    end

  end
end
