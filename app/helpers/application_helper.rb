module ApplicationHelper
  def lbl(model, attr)
    model.class.human_attribute_name attr
  end
end
