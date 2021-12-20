# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

type_of_tastes = ["甘い", "普通", "辛い"]

type_of_tastes.each do |type_of_taste|
  Category.create(
    type_of_taste: type_of_taste
  )
end

taste_intensitys = ["薄い", "普通", "濃い"]

taste_intensitys.each do |taste_intensity|
  Taste.create(
    taste_intensity: taste_intensity
  )
end

major_category_names = ["お菓子", "スイーツ", "冷凍食品", "調味料", "レトルト食品", "インスタント食品","缶詰食品", "びん詰め食品", "果実", "お肉", "その他"]

snack_categories = ["ポテトチップス", "スナック" "ポップコーン", "チョコレート", "ビスケット", "キャンディー", "アイスクリーム"]

sweets_categories = ["ケーキ", "ドーナツ", "ゼリー", "クレープ","焼き菓子", "和菓子"]

frozenfood_categories = ["冷凍チャーハン", "冷凍ポテト", "冷凍餃子","冷凍パスタ", "冷凍ラーメン", "冷凍麺", "冷凍ピザ・グラタン", "冷凍コロッケ", "冷凍調理", "冷凍米飯加工品", "冷凍畜産素材", "冷凍水産素材", "冷凍農産素材" ]

spices_categories = ["砂糖","塩","胡椒","醤油","みりん","料理酒", "酢", "サラダ油", "ごま油", "マヨネーズ", "ソース", "ケチャップ", "コンソメ", "鶏がらスープの素" "カレー粉", "小麦粉", "片栗粉", "めんつゆ", "ポン酢"]

retortfood_categories = ["カレー類（ビーフ、チキン、ポ－ク）","シチュー（クリーム、コーン、トマト）",
                         "ハヤシ、スープ（コーン、ポタージュ、チキン、野菜）","パスタソース",
                         "料理用ソース", "かまめしの素","八宝菜", "マーボー豆腐","丼類の素", "おでん",
                         "ハンバーグ","ミートボール","ヤキトリ", "鶏肉油漬","コンビーフ","ソーセージ","酢豚","ツナの油漬け","ウナギのかば焼き","さんまのかば焼き", "サバみそ煮",
                         "赤飯","五目めし","牛めし" "チキンライス", "とり釜めし","白飯", "おかゆ" "雑炊", "チャーハン","ぜんざい","ベビーフード", "介護食"]

instantfood_categories = ["ラーメン(インスタント)", "インスタントカレー類（ビーフ、チキン、ポ－ク）", "ライス・おかゆ・リゾット(インスタント)", "インスタントスープ・味噌汁",
                        "パスタソース(インスタント)", "調理用スープ", "カップラーメン","カップ焼きそば"]
                        
canning_categories = ["かに缶","さけ缶", "ツナ缶", "さば缶", "いわし缶", "さんま缶", "ほたて缶", "赤貝缶", "あさり缶", "フルーツ缶", "野菜缶詰", "畜肉缶詰", "調理缶詰"]

bottled_categories = ["のりつくだに", "鮭フレーク", "いちご瓶", "マーマレード瓶", "りんご瓶", "ブルーベリー瓶",
                      "ピクルス・オリーブ", "めんつゆ類","ベビーフード", "水産びん詰","野菜びん詰","果実びん詰"]
                      
fruits_categories = ["イチゴ", "マスカット", "桃", "みかん", "リンゴ", "メロン", "梨","マンゴー", "サクランボ", "パイナップル"]

meat_categories = ["牛肉", "豚肉", "鶏肉"]

others = ["その他"]

major_category_names.each do |major_category_name|
  
  if major_category_name == "お菓子"
    
    snack_categories.each do |snack_category|
      Genre.create(name: snack_category, description: snack_category, major_category_name: major_category_name)
    end
  
  elsif major_category_name == "スイーツ"
    
    sweets_categories.each do |sweets_category|
      Genre.create(
        name: sweets_category,
        description: sweets_category,
        major_category_name: major_category_name
      )
    end
    
  elsif major_category_name == "冷凍食品"
    
    frozenfood_categories.each do |frozenfood_category|
      Genre.create(
        name: frozenfood_category,
        description: frozenfood_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "調味料"
    
    spices_categories.each do |spices_category|
      Genre.create(
        name: spices_category,
        description: spices_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "レトルト食品"
    
    retortfood_categories.each do |retortfood_category|
      Genre.create(
        name: retortfood_category,
        description: retortfood_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "インスタント食品"
    
    instantfood_categories.each do |instantfood_category|
      Genre.create(
        name: instantfood_category,
        description: instantfood_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "缶詰食品"
    
    canning_categories.each do |canning_category|
      Genre.create(
        name: canning_category,
        description: canning_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "びん詰め食品"
    
    bottled_categories.each do |bottled_category|
      Genre.create(
        name: bottled_category,
        description: bottled_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "果実"
    
    fruits_categories.each do |fruits_category|
      Genre.create(
        name: fruits_category,
        description: fruits_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "お肉"
    meat_categories.each do |meat_category|
      
      Genre.create(
        name: meat_category,
        description: meat_category,
        major_category_name: major_category_name
      )
    end
  elsif major_category_name == "その他"
    others.each do |other|
      
      Genre.create(
        name: other,
        description: other,
        major_category_name: major_category_name
      )
    end
  end
end