class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def mapped_values
    contents.map do |id, qty|
      name = NeedType.find(id.to_i).name
      CartNeed.new(name, qty)
    end
  end

  def add_need(need_id)
    contents[need_id.to_s] ||= 0
    contents[need_id.to_s] += 1
  end

  def count_all
    contents.values.sum
  end

  def count_of(need_id)
    contents[need_id.to_s]
  end

  def remove_need(need_id)
    contents.delete(need_id)
  end

  def update(need_id, qty)
    contents[need_id.to_s] = qty
  end

  def total_cost
    if contents.empty?
      return 0
    else
      mapped_values.map do |ci|
        ci.subtotal
      end.reduce(:+)
    end
  end
end
