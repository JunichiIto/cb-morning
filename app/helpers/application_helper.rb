module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def lbl(model_or_class, attr)
    klass = model_or_class.is_a?(Class) ? model_or_class : model_or_class.class
    klass.human_attribute_name attr
  end
end
