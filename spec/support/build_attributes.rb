def build_attributes
  ba = FactoryGirl.build(*args).attributes.delete_if do |k, v| 
    ["id", "created_at", "updated_at"].member?(k)
  end
  af = FactoryGirl.attributes_for(*args)
  ba.symbolize_keys.merge(af)
end