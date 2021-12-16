module ProductsHelper
  def score_on_star(recommend)
    return "★★★★★" if recommend == 5
    return "★★★★" if recommend == 4
    return "★★★" if recommend == 3
    return "★★" if recommend == 2
    return "★" if  recommend == 1
  end
end
